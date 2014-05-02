-- Enables Lua unit scripts by including the gadget from springcontent.sdz

-- Uncomment to override the directory which is scanned for *.lua unit scripts.
--UNITSCRIPT_DIR = "scripts/"

return VFS.Include("LuaGadgets/Gadgets/unit_script.lua", nil, VFS.ZIP_ONLY)