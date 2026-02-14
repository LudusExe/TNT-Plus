--costants
local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
INDESTRUCTIBLE = {
    ["mcl_core:bedrock"] = true,
}

c_air     = minetest.get_content_id("air")
c_ignore  = minetest.get_content_id("ignore")
c_bedrock = minetest.get_content_id("mcl_core:bedrock")

dofile(modpath .. "/api.lua")
dofile(modpath .. "/tnts/normal.lua")
dofile(modpath .. "/tnts/special.lua")
dofile(modpath .. "/tnts/nuclear_tnt.lua")
dofile(modpath .. "/tnts/bh_tnt.lua")
dofile(modpath .. "/uranium.lua")
dofile(modpath .. "/crafting.lua")