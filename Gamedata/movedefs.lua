local preProcFile  = 'gamedata/movedefs_pre.lua' -- I don't use this.
local postProcFile = 'gamedata/movedefs_post.lua'

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  Run a pre-processing script if one exists
--

-- if (VFS.FileExists(preProcFile)) then
  -- Shared = shared  -- make it global
  -- MoveDefs = moveDefs  -- make it global
  -- VFS.Include(preProcFile)
  -- MoveDefs = nil
  -- Shared = nil
-- end

local moveDefine	=	VFS.Include("gamedata/movedefs_classes.lua")
local tagList		= 	VFS.Include("gamedata/movedefs_tags.lua")
--------------------------------------------------------------------------------
--
--  Run a post-processing script if one exists
--


for _,mdef in pairs (moveDefine) do
	for tagName,tagVal in pairs (tagList) do
		tagName = string.lower(tagName)
		if( mdef[tagName] == nil and tagVal ~=  0 ) then
			--Spring.Echo("Warning! moveDef: " .. mdef["name"] .. ", assigning default value for missing tag " .. tagName .. "(" .. tagVal .. ")")
			mdef[tagName] = tagVal
		end
	end		
end

if (VFS.FileExists(postProcFile)) then
  Shared = shared  -- make it global
  MoveDefs = moveDefine  -- make it global
  VFS.Include(postProcFile)
  MoveDefs = nil
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return moveDefine

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
