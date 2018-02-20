function widget:GetInfo()
    return {
        name      = "Weather",
        desc      = "Darkens map, with more red colors while the total damages dealt in game increase to give a warfare feeling",
        author    = "Doo",
        date      = "25 april 2015",
        version   = "133.7",
        license   = "GNU GPL, v2 or later",
        layer     = -4,
        enabled   = true,  --  loaded by default?
    }
end

local timeCyclesWeatherEffects = Spring.GetConfigInt("evo_timecyclesweathereffects", 0)
if timeCyclesWeatherEffects ~= 1 then
	return false
end

function widget:Initialize()
    spx,spy,spz = gl.GetSun()
    r = 1
    b = 1
    f = 0
    t = 0
    diffuse = {}
    ambient = {}
    specular = {}
    fogColor = {}
    sunColor = {}
    skyColor = {}
    cloudColor = {}

    newdiffuse = {}
    newambient = {}
    newspecular = {}
    newfogColor = {}
    newsunColor = {}
    newskyColor = {}
    newcloudColor = {}

    X = Game.mapSizeX
    Z = Game.mapSizeZ
    shadowDensity = gl.GetSun("shadowDensity")
    diffuse.r, diffuse.g, diffuse.b = gl.GetSun("diffuse")
    ambient.r, ambient.g, ambient.b = gl.GetSun("ambient")
    specular.r, specular.g, specular.b = gl.GetSun("specular")

    fogStart = gl.GetAtmosphere("fogStart")
    fogEnd = gl.GetAtmosphere("fogEnd")
    fogColor.r, fogColor.g, fogColor.b = gl.GetAtmosphere("fogColor")

    sunColor.r, sunColor.g, sunColor.b = gl.GetAtmosphere("sunColor")
    skyColor.r, skyColor.g, skyColor.b = gl.GetAtmosphere("skyColor")
    cloudColor.r, cloudColor.g, cloudColor.b = gl.GetAtmosphere("cloudColor")

    --water
    -- waterBase = {}
    -- waterAbsorb = {}
    -- waterMin = {}
    -- waterSurface = {}
    -- waterSpecular = {}
    -- waterPlane = {}
    -- newwaterBase = {}
    -- newwaterAbsorb = {}
    -- newwaterMin = {}
    -- newwaterSurface = {}
    -- newwaterSpecular = {}
    -- newwaterPlane = {}

    -- waterBase.r, waterBase.g, waterBase.b = Game.waterBaseColor[1], Game.waterBaseColor[2], Game.waterBaseColor[3]
    -- waterAbsorb.r, waterAbsorb.g, waterAbsorb.b = Game.waterAbsorb[1], Game.waterAbsorb[2], Game.waterAbsorb[3]
    -- waterMin.r, waterMin.g, waterMin.b = Game.waterMinColor[1], Game.waterMinColor[2], Game.waterMinColor[3]
    -- waterSurface.r, waterSurface.g, waterSurface.b = Game.waterSurfaceColor[1], Game.waterSurfaceColor[2], Game.waterSurfaceColor[3]
    -- waterSpecular.r, waterSpecular.g, waterSpecular.b = Game.waterSpecularColor[1], Game.waterSpecularColor[2], Game.waterSpecularColor[3]
    -- waterPlane.r, waterPlane.g, waterPlane.b = Game.waterPlaneColor[1], Game.waterSpecularColor[2], Game.waterSpecularColor[3]
    rain = 0
    roster = Spring.GetPlayerRoster(2)
    nbPlayers = 0
    for i,isSpec in pairs(roster) do
        if isSpec[5] == false then
            nbPlayers = nbPlayers + 1
        end
    end
end

function widget:UnitDestroyed(unitID)
    explosion = UnitDefs[Spring.GetUnitDefID(unitID)].deathExplosion
    maxlightningcolor = 0--(WeaponDefs[WeaponDefNames[explosion].id].damages[1]^0.001 * WeaponDefs[WeaponDefNames[explosion].id].damageAreaOfEffect)/160
    -- Spring.Echo(maxlightningcolor)
    lightning = true
end

function GameStart()
    spx,spy,spz = gl.GetSun()
    r = 1
    roster = Spring.GetPlayerRoster(2)
    nbPlayers = 0
    for i,isSpec in pairs(roster) do
        if isSpec[5] == false then
            nbPlayers = nbPlayers + 1
        end
    end
end

function widget:UnitDamaged(_,_,_,da)
-- if da >= 1500 then
-- da = 1500
-- end
-- b = b + da
end
sunframe = 0
function widget:Update(dt)
    sunframe = sunframe + dt * 0.15
    lightningcolor = 0
    if n == nil or n == 150 then
        n = 1
        lightning = false
    end

    if lightning == true then
        -- Spring.Echo(lightningcolor)
        lightningcolor = (maxlightningcolor/n)/2
        if lightningcolor >= 1 then lightningcolor = 1 end
        if lightningcolor <= 0.025 then lightningcolor = 0 end
        n = n + 1
    end
    -- Spring.Echo(b)
    -- Spring.Echo(r)
    -- Spring.Echo(p)
    -- Spring.Echo(b)
    -- Spring.Echo(r)
    -- Spring.Echo(p)
    r = r + 2000*dt
    -- Spring.Echo(X)
    -- Spring.Echo(Z)
    -- Spring.Echo(X*Z/1000)
    -- Spring.Echo(K)
    K = (X*Z/3500)*nbPlayers
    t = t + dt
    if r>=b then
        r = b
    end
    -- Spring.Echo(w)
    b = b * 0.9995^(dt*30)

    f = f+1
    px,py,pz = gl.GetSun()
    -- Spring.SetSunManualControl(true)
    Spring.SetSunDirection(math.cos(sunframe/15), 1+math.sin(sunframe/16), math.sin(sunframe/15))
    normpx, normpy, normpz = px/math.sqrt(px^2+py^2+pz^2),py/math.sqrt(px^2+py^2+pz^2),pz/math.sqrt(px^2+py^2+pz^2)
    -- Spring.Echo(px)
    if normpy <= 0 then
        normpy = 0
    end
    -- Spring.Echo(normpy)
    -- Spring.Echo(pz)
    p = (1-(normpy))
    w = 1-(math.exp(-r/K))
    rain = (((1 + math.sin(t/50))/2.3)-0.7)*5.7
    if rain < 0 then rain = 0 end

    -- Spring.Echo(p)
    -- Spring.Echo(b)
    -- Spring.Echo(p)
    if p >= 1 then
        p = 1
    end
    if w >= 1 then
        w = 1
    end

    -- Spring.Echo((1-p)*shadowDensity)
    newshadowDensity = (1-p)*shadowDensity
    newdiffuse.r, newdiffuse.g, newdiffuse.b = diffuse.r*(1-p)*(1-w)*(1-rain) + 0.035*1*p*(1-w)*(1-rain) + 0.23*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), diffuse.g*(1-p)*(1-w)*(1-rain)+0.035*1*p*(1-w)*(1-rain)+ 0.07*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), diffuse.b*(1-p)*(1-w)*(1-rain)+0.07*1*p*(1-w)*(1-rain)+ 0.035*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w)
    
	newambient.r, newambient.g, newambient.b = ambient.r, ambient.g, ambient.b -- Use this if it gets too dark
    
	--newambient.r, newambient.g, newambient.b = ambient.r*(1-p)*(1-w)*(1-rain)+ 0.15*1*p*(1-w)*(1-rain)+ 0.69*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), ambient.g*(1-p)*(1-rain)*(1-w)+0.30*1*p*(1-rain)*(1-w)+ 0.30*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), ambient.b*(1-p)*(1-w)*(1-rain)+0.65*1*p*(1-w)*(1-rain)+ 0.15*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w)  -- This is better, but sometimes it gets pitch black
	
    newspecular.r, newspecular.g, newspecular.b = specular.r*(1-p)*(1-w)+0.2*0.60*1*p*(1-w)*(1-rain) + 0.5*rain*(1-p)*(1-w), specular.g*(1-p)*(1-w)+0.2*0.60*1*p*(1-w)*(1-rain) + 0.5*rain*(1-p)*(1-w), specular.b*(1-p)*(1-w)+0.2*1*1*p*(1-w)*(1-rain) + 0.5*rain*(1-p)*(1-w)

    newfogStart = 1-(math.max(rain, w))
    newfogEnd = 15
    newfogColor.r, newfogColor.g, newfogColor.b, newfogColor["alpha"] = fogColor.r*(1-p)*(1-w)*(1-rain)+0.03*1*p*(1-w)*(1-rain)+ 0.07*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), fogColor.g*(1-p)*(1-w)*(1-rain)+0.06*1*p*(1-w)*(1-rain)+ 0.05*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), fogColor.b*(1-p)*(1-w)*(1-rain)+0.20*1*p*(1-w)*(1-rain)+ 0.05*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), 0

    newsunColor.r, newsunColor.g, newsunColor.b = sunColor.r*(1-p)*(1-w)*(1-rain)+0.6*1*p*(1-w)*(1-rain)+ 1*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), sunColor.g*(1-p)*(1-w)*(1-rain)+0.95*1*p*(1-w)*(1-rain)+ 0.95*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), sunColor.b*(1-p)*(1-w)*(1-rain)+0.1*1*p*(1-w)*(1-rain)+ 0.60*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w)
    newskyColor.r, newskyColor.g, newskyColor.b = skyColor.r*(1-p)*(1-w)*(1-rain)+0.03*1*p*(1-w)*(1-rain)+ 0.2*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), skyColor.g*(1-p)*(1-w)*(1-rain)+0.06*1*p*(1-w)*(1-rain)+ 0.06*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w), skyColor.b*(1-p)*(1-w)*(1-rain)+0.2*1*p*(1-w)*(1-rain)+ 0.03*w*(1-p)*(1-rain) + 0.5*rain*(1-p)*(1-w)
    newcloudColor.r, newcloudColor.g, newcloudColor.b = cloudColor.r*(1-p)*(1-w) + 0.5*rain*(1-p)*(1-w), cloudColor.g*(1-p)*(1-w) + 0.5*rain*(1-p)*(1-w), cloudColor.b*(1-p)*(1-w) + 0.5*rain*(1-p)*(1-w)

    if (newdiffuse.r + newdiffuse.g + newdiffuse.b) <= 1.5 then
        factor = 1.5/(newdiffuse.r + newdiffuse.g + newdiffuse.b)
        newdiffuse.r = newdiffuse.r * factor
        newdiffuse.g = newdiffuse.g * factor
        newdiffuse.b = newdiffuse.b * factor
    end

    if (newambient.r + newambient.g + newambient.b) <= 1.5 then
        factor = 1.5/(newdiffuse.r + newdiffuse.g + newdiffuse.b)
        newambient.r = newambient.r * factor
        newambient.g = newambient.g * factor
        newambient.b = newambient.b * factor
    end
    -- Spring.Echo(rain)
    -- Spring.Echo(newfogStart)

    Spring.SetSunLighting({groundAmbientColor = {newambient.r + lightningcolor, newambient.g + lightningcolor, newambient.b + lightningcolor} , groundDiffuseColor = {newdiffuse.r + lightningcolor, newdiffuse.g + lightningcolor, newdiffuse.b + lightningcolor}, groundSpecularColor = {newspecular.r, newspecular.g, newspecular.b}, unitAmbientColor = {newambient.r + lightningcolor, newambient.g + lightningcolor, newambient.b + lightningcolor} , unitDiffuseColor = {newdiffuse.r + lightningcolor, newdiffuse.g + lightningcolor, newdiffuse.b + lightningcolor}, unitSpecularColor = {newspecular.r, newspecular.g, newspecular.b}})
    Spring.SetAtmosphere({fogStart = newfogStart, fogEnd = newfogEnd, fogColor = {newfogColor.r+ lightningcolor, newfogColor.g+ lightningcolor, newfogColor.b+ lightningcolor, 0}, sunColor = {newsunColor.r+ lightningcolor, newsunColor.g+ lightningcolor, newsunColor.b+ lightningcolor}, skyColor = {newskyColor.r , newskyColor.g, newskyColor.b}, cloudColor = {newcloudColor.r+ lightningcolor, newcloudColor.g+ lightningcolor, newcloudColor.b+ lightningcolor}})
    --WATER

    -- Spring.Echo(waterBase.r)
    -- newwaterBase.r, newwaterBase.g, newwaterBase.b = waterBase.r*(1-p)+0.23*p, waterBase.g*(1-p)+0.07*p, waterBase.b*(1-p)+0.035*p
    -- newwaterAbsorb.r, newwaterAbsorb.g, newwaterAbsorb.b = waterAbsorb.r*(1+p), waterAbsorb.g*(1+p), waterAbsorb.b*(1+p)
    -- newwaterMin.r, newwaterMin.g, newwaterMin.b = waterMin.r*(1-p), waterMin.g*(1-p), waterMin.b*(1-p)
    -- newwaterSurface.r, newwaterSurface.g, newwaterSurface.b = waterSurface.r*(1-p)+0.23*p, waterSurface.g*(1-p)+0.07*p, waterSurface.b*(1-p)+0.035*p
    -- newwaterSpecular.r, newwaterSpecular.g, newwaterSpecular.b = waterSpecular.r*(1-p)+0.05*p, waterSpecular.g*(1-p)+0.05*p, waterSpecular.b*(1-p)+0.05*p
    -- newwaterPlane.r, newwaterPlane.g, newwaterPlane.b = waterPlane.r*(1-p)+0.2*p, waterPlane.g*(1-p)+0.06*p, waterPlane.b*(1-p)+0.03*p

    -- Spring.SetWaterParams(
    -- {absorb = {newwaterAbsorb.r, newwaterAbsorb.g, newwaterAbsorb.b}, baseColor = {newwaterBase.r, newwaterBase.g, newwaterBase.b}, minColor = {newwaterMin.r, newwaterMin.g, newwaterMin.b}, surfaceColor = {newwaterSurface.r, newwaterSurface.g, newwaterSurface.b}, diffuseColor = {newdiffuse.r, newdiffuse.g, newdiffuse.b}, specularColor = {newwaterSpecular.r, newwaterSpecular.g, newwaterSpecular.b}, planeColor = {newwaterPlane.r, newwaterPlane.g, newwaterPlane.b}})


end
function widget:Shutdown()
    Spring.SetSunLighting({groundAmbientColor = {ambient.r, ambient.g, ambient.b} , groundDiffuseColor = {diffuse.r, diffuse.g, diffuse.b}, groundSpecularColor = {specular.r, specular.g, specular.b}, unitAmbientColor = {ambient.r, ambient.g, ambient.b} , unitDiffuseColor = {diffuse.r, diffuse.g, diffuse.b}, unitSpecularColor = {specular.r, specular.g, specular.b}})
    Spring.SetAtmosphere({fogStart = fogStart, fogEnd = fogEnd, fogColor = {fogColor.r, fogColor.g, fogColor.b, fogColor.alpha}, sunColor = {sunColor.r, sunColor.g, sunColor.b}, skyColor = {skyColor.r, skyColor.g, skyColor.b}, cloudColor = {cloudColor.r, cloudColor.g, cloudColor.b}})
end