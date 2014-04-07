return {
	vertex = [[
	//#define use_normalmapping
	//#define flip_normalmap
	//#define use_shadows

		%%VERTEX_GLOBAL_NAMESPACE%%

		uniform mat4 camera;	 //ViewMatrix (gl_ModelViewMatrix is ModelMatrix!)
		//uniform mat4 cameraInv;
		uniform vec3 cameraPos;
		uniform vec3 sunPos;
		uniform vec3 sunDiffuse;
		uniform vec3 sunAmbient;
	#ifdef use_shadows
		uniform mat4 shadowMatrix;
		varying vec4 shadowpos;
		#ifndef use_perspective_correct_shadows
			uniform vec4 shadowParams;
		#endif
	#endif

		varying vec3 cameraDir;
		varying vec3 teamColor;
		//varying float fogFactor;

	#ifdef use_normalmapping
		varying vec3 t;
		varying vec3 b;
		varying vec3 n;
	#else
		varying vec3 normalv;
	#endif

	#ifdef bucket_1_texture
		uniform mat4 projectionMatrix1;
		varying vec2 bucket1tc;
	#endif
	#ifdef bucket_2_texture
		uniform mat4 projectionMatrix2;
		varying vec2 bucket2tc;
	#endif

		void main(void)
		{
			vec4 vertex = gl_Vertex;
			vec3 normal = gl_Normal;

			%%VERTEX_PRE_TRANSFORM%%

		#ifdef use_normalmapping
			vec3 tangent	 = gl_MultiTexCoord5.xyz;
			vec3 bitangent = gl_MultiTexCoord6.xyz;
			t = gl_NormalMatrix * tangent;
			b = gl_NormalMatrix * bitangent;
			n = gl_NormalMatrix * normal;
		#else
			normalv = gl_NormalMatrix * normal;
		#endif

			vec4 worldPos = gl_ModelViewMatrix * vertex;
			gl_Position	 = gl_ProjectionMatrix * (camera * worldPos);
			cameraDir		 = worldPos.xyz - cameraPos;

		#ifdef bucket_1_texture
			bucket1tc = (projectionMatrix1 * 
			#ifdef bucket_1_modelcoords
				vertex
			#else
				vec4(gl_MultiTexCoord0.xy, 0.0, 1.0)
			#endif
			).xy;
		#endif

		#ifdef bucket_2_texture
			bucket2tc = (projectionMatrix2 * 
			#ifdef bucket_2_modelcoords
				vertex
			#else
				vec4(gl_MultiTexCoord0.xy, 0.0, 1.0)
			#endif
			).xy;
		#endif
		

		#ifdef use_shadows
			shadowpos = shadowMatrix * worldPos;
			#ifndef use_perspective_correct_shadows
				shadowpos.st = shadowpos.st * (inversesqrt(abs(shadowpos.st) + shadowParams.z) + shadowParams.w) + shadowParams.xy;
			#endif
		#endif

			gl_TexCoord[0].st = gl_MultiTexCoord0.st;
			teamColor = gl_TextureEnvColor[0].rgb;

			//float fogCoord = length(gl_Position.xyz);
			//fogFactor = (gl_Fog.end - fogCoord) * gl_Fog.scale; //gl_Fog.scale := 1.0 / (gl_Fog.end - gl_Fog.start)
			//fogFactor = clamp(fogFactor, 0.0, 1.0);

			%%VERTEX_POST_TRANSFORM%%
		}
	]],
	fragment = [[
	//#define use_normalmapping
	//#define flip_normalmap
	//#define use_shadows

		%%FRAGMENT_GLOBAL_NAMESPACE%%

		uniform sampler2D textureS3o1;
		uniform sampler2D textureS3o2;
		uniform samplerCube specularTex;
		uniform samplerCube reflectTex;

		uniform vec3 sunPos; // is sunDir!
		uniform vec3 sunDiffuse;
		uniform vec3 sunAmbient;
	

	#ifdef use_shadows
		#ifdef use_perspective_correct_shadows
			uniform vec4 shadowParams;
		#endif
		varying vec4 shadowpos;
		uniform sampler2DShadow shadowTex;
		uniform float shadowDensity;
	#endif

		varying vec3 teamColor;
		varying vec3 cameraDir;
		//varying float fogFactor;

	#ifdef use_normalmapping
		varying vec3 t;
		varying vec3 b;
		varying vec3 n;
		uniform sampler2D normalMap;
	#else
		varying vec3 normalv;
	#endif
	
	#ifdef use_buckets
		uniform sampler2D bucketMap;
		uniform vec4 paintR;
		uniform vec4 paintG;
		uniform vec4 paintB;
		uniform vec4 paintA;
		uniform vec4 sheenR;
		uniform vec4 sheenG;
		uniform vec4 sheenB;
		uniform vec4 sheenA;
	
		#ifdef bucket_1_texture
			varying vec2 bucket1tc;
			uniform sampler2D projectionTex1;
		#endif
		#ifdef bucket_2_texture
			varying vec2 bucket2tc;
			uniform sampler2D projectionTex2;
		#endif

	#endif

		void main(void)
		{
			%%FRAGMENT_PRE_SHADING%%

		#ifdef use_normalmapping
			vec2 tc = gl_TexCoord[0].st;
			#ifdef flip_normalmap
				tc.t = 1.0 - tc.t;
			#endif
		 vec4 normaltex=texture2D(normalMap, tc);
			vec3 nvTS	 = normalize(normaltex.xyz - 0.5);
			vec3 normal = normalize(mat3(t,b,n) * nvTS);
		#else
			vec3 normal = normalize(normalv);
		#endif
			float a		= max( dot(normal, sunPos), 0.0);
			vec3 light = a * sunDiffuse + sunAmbient;

			vec4 extraColor = texture2D(textureS3o2, gl_TexCoord[0].st);
			vec3 reflectDir = reflect(cameraDir, normal);
			vec3 specTex	= textureCube(specularTex, reflectDir).rgb;
			vec3 specular	= specTex * extraColor.g;
			vec3 reflection = textureCube(reflectTex,	reflectDir).rgb;

		#ifdef use_shadows
			vec4 shadowTC = shadowpos;
			#ifdef use_perspective_correct_shadows
				shadowTC.st = shadowTC.st * (inversesqrt( abs(shadowTC.st) + shadowParams.z) + shadowParams.w) + shadowParams.xy;
			#endif
			float shadow = shadow2DProj(shadowTex, shadowTC).r;
			shadow		= 1.0 - (1.0 - shadow) * shadowDensity;
			light		 = mix(sunAmbient, light, shadow);
			specular *= shadow;
		#endif

		//reflection	= mix(light, reflection, extraColor.b); // reflection
		//reflection	+= extraColor.rrr;// self-illum
		

		vec4 tex1 = texture2D(textureS3o1, gl_TexCoord[0].st);
		
		tex1.rgb = mix(tex1.rgb, teamColor.rgb, tex1.a); // teamcolor
		
		#ifdef use_buckets
			vec4 bucketMult = texture2D(bucketMap, tc).rgba;
			//bucketMult		= (bucketMult.r, bucketMult.g, bucketMult.b, 1 - bucketMult.a)
			
			vec3 bucketColour = vec3(0);
			bucketColour += paintR.rgb
			#ifdef bucket_1_texture
				* texture2D(projectionTex1, bucket1tc).rgb
			#endif
			* (bucketMult.r*bucketMult.r*paintR.a);

			bucketColour += paintG.rgb
			#ifdef bucket_2_texture
				* texture2D(projectionTex2, bucket2tc).rgb
			#endif
			* (bucketMult.g*bucketMult.g*paintG.a);

			bucketColour += paintB.rgb*(bucketMult.b*bucketMult.b*paintB.a);//mix(bucketColour, paintB.rgb, bucketMult.b*paintB.a);
			bucketColour += paintA.rgb*((1-(bucketMult.a*bucketMult.a))*paintA.a);//mix(bucketColour, paintA.rgb, bucketMult.a*paintA.a);
	
			vec3 spec =  (pow(max( dot(normal, sunPos), 0.0),2.0) * sunDiffuse + sunAmbient)*specTex;
			vec3 specular2color = 	(spec*sheenR.rgb*bucketMult.r)*sheenR.a*6 +
									(spec*sheenG.rgb*bucketMult.g)*sheenG.a*6 +
									spec*sheenB.rgb*bucketMult.b*sheenB.a*6 +
									spec*sheenA.rgb*((1-bucketMult.a)*sheenA.a*6);
									
			vec3 ref	= 	reflection*extraColor.b +
							reflection*bucketMult.r*sheenR.a +
							reflection*bucketMult.g*sheenG.a +
							reflection*bucketMult.b*sheenB.a +
							reflection*((1-bucketMult.a)*sheenA.a)+ light/2.5 ;
			
			ref	+= extraColor.rrr;// self-illum		
			gl_FragColor.rgb = (bucketColour + tex1.rgb) * light * (ref *3) + (specular+specular2color)/2;
		#else
			reflection	= mix(light, reflection, extraColor.b); // reflection
			reflection	+= extraColor.rrr;// self-illum
		
			gl_FragColor.rgb = tex1.rgb * reflection + specular;
		#endif
		
		
		gl_FragColor.a	 = extraColor.a;
		//gl_FragColor.rgb = mix(gl_Fog.color.rgb, gl_FragColor.rgb, fogFactor); // fog
		//gl_FragColor.a = teamColor.a; // far fading
		
		//gl_FragColor.rgb = texture2D(bucketMap, tc).rgb;

		%%FRAGMENT_POST_SHADING%%
		}
	]],
	
	uniformInt = {
		textureS3o1		= 0,
		textureS3o2		= 1,
		shadowTex		= 2,
		specularTex		= 3,
		reflectTex		= 4,
		normalMap		= 5,
		bucketMap		= 6,
		projectionTex1	= 7,
		projectionTex2	= 8,
	},
	
	uniform = {
		sunPos			= {gl.GetSun("pos")},
		sunAmbient		= {gl.GetSun("ambient" ,"unit")},
		sunDiffuse		= {gl.GetSun("diffuse" ,"unit")},
		shadowDensity	= {gl.GetSun("shadowDensity" ,"unit")},
		shadowParams	= {gl.GetShadowMapParams()},
		
		paintR 	= {1,1,1,1},
		paintG 	= {1,1,1,1},
		paintB 	= {1,1,1,1},
		paintA 	= {1,1,1,0},
		sheenR	= {1,1,1,0},
		sheenG	= {1,1,1,0},
		sheenB	= {1,1,1,0},
		sheenA	= {1,1,1,0},
	},
	
	uniformMatrix = {
		shadowMatrix = {gl.GetMatrixData("shadow")},
		projectionMatrix1 = {
			0.5,0.5,0.0,0,
			0.5,0.0,0.0,0,
			0.0,0.5,0.5,0,
			0.0,0.0,0.0,1
		},
		projectionMatrix2 = {
			0.5,0.5,0.0,0,
			0.5,0.0,0.0,0,
			0.0,0.5,0.5,0,
			0.0,0.0,0.0,1
		},
	},
}
