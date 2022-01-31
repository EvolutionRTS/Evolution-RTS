-- this file gets included in alldefs_post.lua
function convertToPurple(value)
    value = string.gsub(value, '-red', '-purple')
    value = string.gsub(value, '-green', '-purple')
    value = string.gsub(value, '-blue', '-purple')
    value = string.gsub(value, '-yellow', '-purple')
    return value
end

local function split(s, separator)
    local results = {}
    for part in s:gmatch("[^"..separator.."]+") do
        results[#results + 1] = part
    end
    return results
end

function scav_Wdef_Post(name, wDef)
    if wDef.weapontype == "Cannon" then
		--Spring.Echo(wDef.name,wDef.weapontype)
		wDef.rgbcolor = {0.96, 0.42, 1}
        if wDef.explosiongenerator then
            --wDef.explosiongenerator = "custom:genericscavengershellexplosion-medium-purple"
        end
		if wDef.cegtag then
			wDef.cegtag = "scavengercegtag"
		end
    elseif wDef.weapontype == "MissileLauncher" or wDef.weapontype == "StarburstLauncher" then
        if wDef.explosiongenerator then
            --wDef.explosiongenerator = "custom:genericscavengershellexplosion-medium-purple"
        end
        if wDef.cegtag then
            wDef.cegtag = "scavengercegtag"
        end
    elseif wDef.weapontype == "LightningCannon" then
	    wDef.rgbcolor = {0.95, 0.32, 1}
	    wDef.customparams.expl_light_color = {0.95, 0.32, 1}
		wDef.customparams.light_color = {0.95, 0.32, 1}
		--wDef.rgbcolor = {0.95, 0.0, 1} Damgam Candy mode
	    --wDef.customparams.expl_light_color = {0.95, 0.0, 1} Damgam Candy mode
		--wDef.customparams.light_color = {0.95, 0.0, 1} Damgam Candy mode
		--wDef.explosiongenerator = "custom:genericscavengershellexplosion-medium-lightning"
    elseif wDef.weapontype == "BeamLaser" or wDef.weapontype == "LaserCannon" or wDef.weapontype == "DGun" then
        wDef.rgbcolor = {0.95, 0.32, 1}
		--wDef.rgbcolor = {0.95, 0.0, 1} Damgam Candy mode
        wDef.rgbcolor2 = {1, 0.8, 1}
    end
    -- make lighting purple (sort of: by switching around the rgb values)
    if wDef.customparams then
        for k, v in pairs(wDef.customparams) do
            if type(v) == 'string' and string.find(k, 'light_color') then
                local colors = split(v, ' ')
                if colors[1] and colors[3] and colors[1] == '1' then
                    wDef.customparams[k] = colors[2]..' '..colors[3]..' '..colors[1]
                end
            end
        end
    end
    return wDef
end
