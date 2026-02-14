--tnts
minetest.register_craft({
    output = "tnt_plus:tnt_x2",
    recipe = {
        {"mcl_core:gravel", "mcl_core:sand", "mcl_core:gravel"},
        {"mcl_core:sand", "mcl_tnt:tnt", "mcl_core:sand"},
        {"mcl_core:gravel", "mcl_core:sand", "mcl_core:gravel"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_x5",
    recipe = {
        {"mcl_core:gravel", "mcl_core:gravel", "mcl_core:gravel"},
        {"mcl_core:gravel", "mcl_tnt:tnt_x2", "mcl_core:gravel"},
        {"mcl_core:gravel", "mcl_core:gravel", "mcl_core:gravel"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_x20",
    recipe = {
        {"tnt_plus:tnt_x5", "mcl_core:gravel", "tnt_plus:tnt_x5"},
        {"mcl_core:gravel", "tnt_plus:tnt_x5", "mcl_core:gravel"},
        {"tnt_plus:tnt_x5", "mcl_core:gravel", "tnt_plus:tnt_x5"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_x100",
    recipe = {
        {"tnt_plus:tnt_x20", "mcl_core:sand", "tnt_plus:tnt_x20"},
        {"mcl_core:sand", "tnt_plus:tnt_x20", "mcl_core:sand"},
        {"tnt_plus:tnt_x20", "mcl_core:sand", "tnt_plus:tnt_x20"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_x500",
    recipe = {
        {"tnt_plus:tnt_x100", "mcl_core:gravel", "tnt_plus:tnt_x100"},
        {"mcl_core:gravel", "tnt_plus:tnt_x100", "mcl_core:gravel"},
        {"tnt_plus:tnt_x100", "mcl_core:gravel", "tnt_plus:tnt_x100"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_freeze",
    recipe = {
        {"mcl_core:ice", "mcl_core:packed_ice", "mcl_core:ice"},
        {"mcl_core:packed_ice", "mcl_tnt:tnt", "mcl_core:packed_ice"},
        {"mcl_core:ice", "mcl_core:packed_ice", "mcl_core:ice"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_lava",
    recipe = {
        {"mcl_buckets:bucket_lava", "mcl_core:gravel", "mcl_buckets:bucket_lava"},
        {"mcl_core:gravel", "mcl_tnt:tnt", "mcl_core:gravel"},
        {"mcl_buckets:bucket_lava", "mcl_core:gravel", "mcl_buckets:bucket_lava"},
    },
    replacements = {
        {"mcl_buckets:bucket_lava", "mcl_buckets:bucket_empty"},
        {"mcl_buckets:bucket_lava", "mcl_buckets:bucket_empty"},
        {"mcl_buckets:bucket_lava", "mcl_buckets:bucket_empty"},
        {"mcl_buckets:bucket_lava", "mcl_buckets:bucket_empty"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_water",
    recipe = {
        {"mcl_buckets:bucket_water", "mcl_core:sand", "mcl_buckets:bucket_water"},
        {"mcl_core:sand", "mcl_tnt:tnt", "mcl_core:sand"},
        {"mcl_buckets:bucket_water", "mcl_core:sand", "mcl_buckets:bucket_water"},
    },
    replacements = {
        {"mcl_buckets:bucket_water", "mcl_buckets:bucket_empty"},
        {"mcl_buckets:bucket_water", "mcl_buckets:bucket_empty"},
        {"mcl_buckets:bucket_water", "mcl_buckets:bucket_empty"},
        {"mcl_buckets:bucket_water", "mcl_buckets:bucket_empty"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_flat",
    recipe = {
        {"mcl_core:gravel", "mcl_core:sand", "mcl_core:gravel"},
        {"mcl_tnt:tnt", "mcl_tnt:tnt", "mcl_tnt:tnt"},
        {"mcl_core:gravel", "mcl_core:sand", "mcl_core:gravel"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_flat_mount",
    recipe = {
        {"tnt_plus:tnt_flat", "mcl_core:gravel", "tnt_plus:tnt_flat"},
        {"mcl_tnt:tnt", "mcl_tnt:tnt", "mcl_tnt:tnt"},
        {"tnt_plus:tnt_flat", "mcl_core:gravel", "tnt_plus:tnt_flat"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_vertical",
    recipe = {
        {"mcl_core:sand", "mcl_tnt:tnt", "mcl_core:sand"},
        {"mcl_core:sand", "mcl_tnt:tnt", "mcl_core:sand"},
        {"mcl_core:sand", "mcl_tnt:tnt", "mcl_core:sand"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_tent",
    recipe = {
        {"", "mcl_wool:white", ""},
        {"mcl_wool:white", "tnt_plus:tnt_x5", "mcl_wool:white"},
        {"mcl_wool:white", "mcl_crafting_table:crafting_table", "mcl_wool:white"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_house",
    recipe = {
        {"mcl_core:wood", "mcl_furnaces:furnace", "mcl_core:wood"},
        {"mcl_crafting_table:crafting_table", "tnt_plus:tnt_x5", "mcl_beds:bed_red_bottom"},
        {"mcl_core:wood", "mcl_core:wood", "mcl_core:wood"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_rain",
    recipe = {
        {"mcl_buckets:bucket_water", "tnt_plus:tnt_water", "mcl_buckets:bucket_water"},
        {"tnt_plus:tnt_water", "tnt_plus:tnt_water", "tnt_plus:tnt_water"},
        {"mcl_buckets:bucket_water", "tnt_plus:tnt_water", "mcl_buckets:bucket_water"},
    },
    replacements = {
        {"mcl_buckets:bucket_water", "mcl_buckets:bucket_empty"},
        {"mcl_buckets:bucket_water", "mcl_buckets:bucket_empty"},
        {"mcl_buckets:bucket_water", "mcl_buckets:bucket_empty"},
        {"mcl_buckets:bucket_water", "mcl_buckets:bucket_empty"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_air",
    recipe = {
        {"tnt_plus:tnt_x100", "mcl_core:gravel", "tnt_plus:tnt_x100"},
        {"mcl_core:gravel", "mcl_tnt:tnt", "mcl_core:gravel"},
        {"tnt_plus:tnt_x100", "mcl_core:gravel", "tnt_plus:tnt_x100"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_mob",
    recipe = {
        {"mcl_mobitems:rotten_flesh", "mcl_mobitems:bone", "mcl_mobitems:rotten_flesh"},
        {"mcl_mobitems:spider_eye", "mcl_tnt:tnt", "mcl_mobitems:spider_eye"},
        {"mcl_mobitems:rotten_flesh", "mcl_mobitems:gunpowder", "mcl_mobitems:rotten_flesh"},
    }
})

-- endgame tnt
minetest.register_craft({
    output = "tnt_plus:tnt_atomic",
    recipe = {
        {"tnt_plus:tnt_x500", "tnt_plus:uranium_ingot", "tnt_plus:tnt_x500"},
        {"tnt_plus:uranium_ingot", "tnt_plus:uranium_block", "tnt_plus:uranium_ingot"},
        {"tnt_plus:tnt_x500", "tnt_plus:uranium_ingot", "tnt_plus:tnt_x500"},
    }
})
minetest.register_craft({
    output = "tnt_plus:tnt_blackhole",
    recipe = {
        {"tnt_plus:tnt_atomic", "tnt_plus:tnt_x500", "tnt_plus:tnt_atomic"},
        {"tnt_plus:tnt_x500", "tnt_plus:uranium_block", "tnt_plus:tnt_x500"},
        {"tnt_plus:tnt_atomic", "tnt_plus:tnt_x500", "tnt_plus:tnt_atomic"},
    }
})

-- uranium stuff
minetest.register_craft({
    type = "cooking",
    output = "tnt_plus:uranium_ingot",
    recipe = "tnt_plus:uranium_dust",
    cooktime = 10,
})
minetest.register_craft({
    output = "tnt_plus:uranium_block",
    recipe = {
        {"tnt_plus:uranium_ingot","tnt_plus:uranium_ingot","tnt_plus:uranium_ingot"},
        {"tnt_plus:uranium_ingot","tnt_plus:uranium_ingot","tnt_plus:uranium_ingot"},
        {"tnt_plus:uranium_ingot","tnt_plus:uranium_ingot","tnt_plus:uranium_ingot"},
    }
})
minetest.register_craft({
	output = "tnt_plus:pick_uranium",
	recipe = {
		{"tnt_plus:uranium_ingot", "tnt_plus:uranium_ingot", "tnt_plus:uranium_ingot"},
		{"", "mcl_core:stick", ""},
		{"", "mcl_core:stick", ""},
	}
})
minetest.register_craft({
	output = "tnt_plus:axe_uranium",
	recipe = {
		{"tnt_plus:uranium_ingot", "tnt_plus:uranium_ingot", ""},
		{"tnt_plus:uranium_ingot", "mcl_core:stick", ""},
		{"", "mcl_core:stick", ""},
	}
})
minetest.register_craft({
	output = "tnt_plus:sword_uranium",
	recipe = {
		{"tnt_plus:uranium_ingot"},
		{"tnt_plus:uranium_ingot"},
		{"mcl_core:stick"},
	}
})
minetest.register_craft({
	output = "tnt_plus:shovel_uranium",
	recipe = {
		{"tnt_plus:uranium_ingot"},
		{"mcl_core:stick"},
		{"mcl_core:stick"},
	}
})
minetest.register_craft({
	output = "tnt_plus:hoe_uranium",
	recipe = {
		{"tnt_plus:uranium_ingot", "tnt_plus:uranium_ingot", ""},
		{"", "mcl_core:stick", ""},
		{"", "mcl_core:stick", ""},
	}
})