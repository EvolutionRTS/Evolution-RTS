//http://glsl.heroku.com/e#9548.0

// fuck that shit.

#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

const float pi = 3.14159;

float hash(float x)
{
	return fract(sin(x) * 43758.5453);
}

float noise(vec3 x)
{
	vec3 p = floor(x);
	vec3 f = fract(x);
	f = f*f*(3.0-2.0*f);
	float n = p.x + p.y * 57.0 + p.z*113.0;

	float a = hash(n);
	return a;
}

float cheby(vec3 v)
{
	v = abs(v);
	return v.x > v.y
	? (v.x > v.z ? v.x : v.z)
	: (v.y > v.z ? v.y : v.z);
}

float someMetric(vec3 v)
{
	return  (pow(v.x,2.0) + pow(v.y,2.0) + pow(v.z,2.0));
}

float vor(vec3 v)
{
	vec3 start = floor(v);

	float dist = 32.0;
	vec3 cand;

	for(int z = -2; z <= 2; z += 1)
	{
		for(int y = -2; y <= 2; y += 1)
		{
			for(int x = -2; x <= 2; x += 1)
			{
				vec3 t = start + vec3(x, y, z);
				vec3 p = t + noise(t);

				float d = someMetric(p - v);
				if(d < dist)
				{
					dist = d;
					cand = p;
				}
			}
		}
	}

	vec3 delta = cand - v;

	return someMetric(delta);
}

vec3 voroni( vec3 p)
{
	vec3 v = vec3(3. * p + time*0.2);

	float w = vor(v);

	return w * p;
}


vec3 rotate(vec3 v,vec2 r)
{
	mat3 rxmat = mat3(1,   0    ,    0    ,
			  0,cos(r.y),-sin(r.y),
			  0,sin(r.y), cos(r.y));
	mat3 rymat = mat3(cos(r.x), 0,-sin(r.x),
			     0    , 1,    0    ,
			  sin(r.x), 0,cos(r.x));


	return v*rxmat*rymat;

}

float snoise(vec3 v);

void main( void ) {

	vec2 res = vec2(resolution.x/resolution.y,1.0);
	vec2 p = ( gl_FragCoord.xy / resolution.y ) -(res/2.0);

	vec2 m = pi*vec2(1.0+sin(time*0.23)*0.08,1.0+sin(time*0.21)*0.05);

	vec3 pos = normalize(rotate(vec3(p,0.5),vec2(m)));

	float dist = 0.0;

	vec3 c = vec3(0.);

	float sn = 1.-snoise(pos-time*0.2);

	vec3 v0 = voroni(pos);
	vec3 v1 = voroni(pos*2.8);
	vec3 v = v0*v1;
	pos = v;
	pos += v0;

	for(float i = 1.;i <= 8.;i++)
	{

		float shell = sn-(length(sn-pos)/i);

		shell = smoothstep(1.,.0,shell);

		dist = max(dist, shell*(1.-(i/3.)));
	}

	vec3 o = vec3(p, 0.0);
	vec3 n = normalize(dist*pos);

	c = mix(vec3(.8, .4,.2), vec3(.4,.3,.3), dist) / dist;

	float f = 0.1 * (dist + sn / length(pos));

	vec3 lp = (-dist - sn) + n * pos;
	vec3 ld = normalize(o-lp);

	float i = dist * length(pos/sn);
	vec3 lc = vec3(.8, .6, .4);

	float ndl = dot(n, ld);
	ndl = dot(normalize(o - lp - v), dist-pos);

	vec3 h = normalize(pos - ld);
	float ndh = max(0.0, dot(n, h));
	float s = max(0., pow(128., .63 * ndh)) * .92;
	vec3 sc = vec3(0.5, 0.4, .3);

//	c = (c * ndl * i * lc) + (s * ndl * sc / dist) * f;
	c = (c * ndl * i * lc);

	c.r *= mod(gl_FragCoord.y, 2.0);
	gl_FragColor = vec4(c.xyz , 1.0 );
	//sphinx
}

//
// Description : Array and textureless GLSL 2D/3D/4D simplex
//               noise functions.
//      Author : Ian McEwan, Ashima Arts.
//  Maintainer : ijm
//     Lastmod : 20110822 (ijm)
//     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
//               Distributed under the MIT License. See LICENSE file.
//               https://github.com/ashima/webgl-noise
//

vec3 mod289(vec3 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 mod289(vec4 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 permute(vec4 x) {
     return mod289(((x*34.0)+1.0)*x);
}

vec4 taylorInvSqrt(vec4 r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}

float snoise(vec3 v)
  {
  const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
  const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

// First corner
  vec3 i  = floor(v + dot(v, C.yyy) );
  vec3 x0 =   v - i + dot(i, C.xxx) ;

// Other corners
  vec3 g = step(x0.yzx, x0.xyz);
  vec3 l = 1.0 - g;
  vec3 i1 = min( g.xyz, l.zxy );
  vec3 i2 = max( g.xyz, l.zxy );

  //   x0 = x0 - 0.0 + 0.0 * C.xxx;
  //   x1 = x0 - i1  + 1.0 * C.xxx;
  //   x2 = x0 - i2  + 2.0 * C.xxx;
  //   x3 = x0 - 1.0 + 3.0 * C.xxx;
  vec3 x1 = x0 - i1 + C.xxx;
  vec3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
  vec3 x3 = x0 - D.yyy;      // -1.0+3.0*C.x = -0.5 = -D.y

// Permutations
  i = mod289(i);
  vec4 p = permute( permute( permute(
             i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
           + i.y + vec4(0.0, i1.y, i2.y, 1.0 ))
           + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));

// Gradients: 7x7 points over a square, mapped onto an octahedron.
// The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
  float n_ = 0.142857142857; // 1.0/7.0
  vec3  ns = n_ * D.wyz - D.xzx;

  vec4 j = p - 49.0 * floor(p * ns.z * ns.z);  //  mod(p,7*7)

  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

  vec4 x = x_ *ns.x + ns.yyyy;
  vec4 y = y_ *ns.x + ns.yyyy;
  vec4 h = 1.0 - abs(x) - abs(y);

  vec4 b0 = vec4( x.xy, y.xy );
  vec4 b1 = vec4( x.zw, y.zw );

  //vec4 s0 = vec4(lessThan(b0,0.0))*2.0 - 1.0;
  //vec4 s1 = vec4(lessThan(b1,0.0))*2.0 - 1.0;
  vec4 s0 = floor(b0)*2.0 + 1.0;
  vec4 s1 = floor(b1)*2.0 + 1.0;
  vec4 sh = -step(h, vec4(0.0));

  vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
  vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

  vec3 p0 = vec3(a0.xy,h.x);
  vec3 p1 = vec3(a0.zw,h.y);
  vec3 p2 = vec3(a1.xy,h.z);
  vec3 p3 = vec3(a1.zw,h.w);

//Normalise gradients
  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

// Mix final noise value
  vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1),
                                dot(p2,x2), dot(p3,x3) ) );
}
