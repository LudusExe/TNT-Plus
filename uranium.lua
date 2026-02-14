local S = minetest.get_translator("tnt_plus")	--this was a separated mod, but they are cool together
local hoe_tt = S("Used to till soil")

local exploding = {}

local function uranium_explode(player)
	if not player then return end
	if math.random(100) ~= 1 then return end

	local name = player:get_player_name()
	if exploding[name] then return end
	exploding[name] = true

	local pos = vector.round(player:get_pos())

	minetest.after(0, function()
		if minetest.get_modpath("mcl_tnt") and mcl_explosions then
			mcl_explosions.explode(pos, 2, {
				drop_chance = 0,
				fire = false,
			})
		end
		exploding[name] = nil
	end)
end


core.register_craftitem("tnt_plus:uranium_dust", {
    description = "Uranium Dust",
    inventory_image = "tnt_plus_uranium_dust.png",
})

core.register_craftitem("tnt_plus:uranium_ingot", {
    description = "Uranium Ingot",
    inventory_image = "tnt_plus_uranium_ingot.png",
})

core.register_node("tnt_plus:uranium_block", {
    description = "Uranium Block",
    tiles = {"tnt_plus_uranium_block.png"},
    groups = {pickaxe = 1},
    _mcl_hardness = 4.0,
    _mcl_mining_level = 3,
    _mcl_blast_resistance = 6,
    light_source = 10,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
        local player_name = digger:get_player_name()
        local do_explode = math.random() < 0.2
		core.add_item(pos, "tnt_plus:uranium_ingot 9")
        if do_explode and core.get_modpath("mcl_tnt") and mcl_explosions then
        mcl_explosions.explode(pos, 8)
        elseif do_explode then
            core.chat_send_player(player_name, "mcl_tnt not available.")
        end
    end,
})

core.register_node("tnt_plus:uranium_ore", {
    description = "Uranium Ore",
    tiles = {"tnt_plus_uranium_ore.png"},
    groups = {pickaxe = 1},
    _mcl_hardness = 3.0,
    _mcl_mining_level = 2,
    _mcl_blast_resistance = 6,
    light_source = 8,
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        local player_name = digger:get_player_name()
        local do_explode = math.random() < 0.2
        core.add_item(pos, "tnt_plus:uranium_dust")
        if do_explode and core.get_modpath("mcl_tnt") and mcl_explosions then
        mcl_explosions.explode(pos, 4)
        elseif do_explode then
            core.chat_send_player(player_name, "mcl_tnt not available.")
        end
    end,
})

core.register_ore({
    ore_type       = "scatter",
    ore            = "tnt_plus:uranium_ore",
    wherein        = "mcl_core:stone",
    clust_scarcity = 2000,
    clust_num_ores = 4,
    clust_size     = 2,
    y_min          = -60,
    y_max          = -40,
})

--tools
--code took from the netherite tools
core.register_tool("tnt_plus:pick_uranium", {
	description = S("Uranium Pickaxe"),
	_doc_items_longdesc = pickaxe_longdesc,
	inventory_image = "tnt_plus_uraniumpick.png",
	wield_scale = wield_scale,
	groups = { tool=1, pickaxe=1, dig_speed_class=6, enchantability=10, fire_immune=1 },
	tool_capabilities = {
		-- 1/1.2
		full_punch_interval = 0.83333333,
		max_drop_level=5,
		damage_groups = {fleshy=6},
		punch_attack_uses = 1016,
	},
	after_use = function(itemstack, user, node, digparams)
	uranium_explode(user)
	return itemstack
end,

	sound = { breaks = "default_tool_breaks" },
	_repair_material = "tnt_plus:uranium_ingot",
	_mcl_toollike_wield = true,
	_mcl_diggroups = {
		pickaxey = { speed = 9.5, level = 6, uses = 2031 }
	},
	
})

core.register_tool("tnt_plus:shovel_uranium", {
	description = S("Uranium Shovel"),
	_doc_items_longdesc = shovel_longdesc,
	_doc_items_usagehelp = shovel_use,
	inventory_image = "tnt_plus_uraniumshovel.png",
	wield_scale = wield_scale,
	groups = { tool=1, shovel=1, dig_speed_class=6, enchantability=10, fire_immune=1 },
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=5,
		damage_groups = {fleshy=5},
		punch_attack_uses = 1016,
	},
	after_use = function(itemstack, user, node, digparams)
	uranium_explode(user)
	return itemstack
end,

	on_place = make_grass_path,
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "tnt_plus:uranium_ingot",
	_mcl_toollike_wield = true,
	_mcl_diggroups = {
		shovely = { speed = 9, level = 6, uses = 2031 }
	},
})


core.register_tool("tnt_plus:axe_uranium", {
	description = S("Uranium Axe"),
	_doc_items_longdesc = axe_longdesc,
	inventory_image = "tnt_plus_uraniumaxe.png",
	wield_scale = wield_scale,
	groups = { tool=1, axe=1, dig_speed_class=6, enchantability=10, fire_immune=1 },
	after_use = function(itemstack, user, node, digparams)
	uranium_explode(user)
	return itemstack
end,

	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=5,
		damage_groups = {fleshy=10},
		punch_attack_uses = 1016,
	},
	on_place = make_stripped_trunk,
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "tnt_plus:uranium_ingot",
	_mcl_toollike_wield = true,
	_mcl_diggroups = {
		axey = { speed = 9, level = 6, uses = 2031 }
	},
})

core.register_tool("tnt_plus:sword_uranium", {
	description = S("Uranium Sword"),
	_doc_items_longdesc = sword_longdesc,
	inventory_image = "tnt_plus_uraniumsword.png",
	wield_scale = wield_scale,
	groups = { weapon=1, sword=1, dig_speed_class=5, enchantability=10, fire_immune=1 },
	tool_capabilities = {
		full_punch_interval = 0.625,
		max_drop_level=5,
		damage_groups = {fleshy=9},
		punch_attack_uses = 2031,
	},
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "tnt_plus:uranium_ingot",
	_mcl_toollike_wield = true,
	_mcl_diggroups = {
		swordy = { speed = 8, level = 5, uses = 2031 },
		swordy_cobweb = { speed = 8, level = 5, uses = 2031 }
	},
})
minetest.register_on_punchplayer(function(player, hitter)
	if not hitter then return end

	local item = hitter:get_wielded_item():get_name()
	if item == "tnt_plus:sword_uranium" then
		uranium_explode(hitter)
	end
end)
minetest.after(0, function()
	for name, def in pairs(minetest.registered_entities) do
		if def.on_punch and not def._uranium_wrapped then
			local old_on_punch = def.on_punch

			def.on_punch = function(self, hitter, time_from_last_punch, tool_caps, dir, damage)
				if hitter and hitter:is_player() then
					local item = hitter:get_wielded_item():get_name()
					if item == "tnt_plus:sword_uranium" then
						uranium_explode(hitter)
					end
				end

				return old_on_punch(self, hitter, time_from_last_punch, tool_caps, dir, damage)
			end

			def._uranium_wrapped = true
		end
	end
end)



--hoe function
local function create_soil(pos, inv)
	if pos == nil then
		return false
	end
	local node = minetest.get_node(pos)
	local name = node.name
	local above = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
	if minetest.get_item_group(name, "cultivatable") == 2 then
		if above.name == "air" then
			node.name = "mcl_farming:soil"
			minetest.set_node(pos, node)
			minetest.sound_play("default_dig_crumbly", { pos = pos, gain = 0.5 }, true)
			return true
		end
	elseif minetest.get_item_group(name, "cultivatable") == 1 then
		if above.name == "air" then
			node.name = "mcl_core:dirt"
			minetest.set_node(pos, node)
			minetest.sound_play("default_dig_crumbly", { pos = pos, gain = 0.6 }, true)
			return true
		end
	end
	return false
end
local hoe_on_place_function = function(wear_divisor)
	return function(itemstack, user, pointed_thing)
		local node = minetest.get_node(pointed_thing.under)
		if user and not user:get_player_control().sneak then
			if minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].on_rightclick then
				return minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, user, itemstack) or itemstack
			end
		end

		if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
			minetest.record_protection_violation(pointed_thing.under, user:get_player_name())
			return itemstack
		end

		if create_soil(pointed_thing.under, user:get_inventory()) then
	uranium_explode(user)
	if not minetest.is_creative_enabled(user:get_player_name()) then
		itemstack:add_wear(65535/wear_divisor)
	end
	return itemstack
end

	end
end


local uses = {
	uranium = 119,
}

core.register_tool("tnt_plus:hoe_uranium", {
	description = S("Uranium Hoe"),
	_tt_help = hoe_tt.."\n"..S("Uses: @1", uses.uranium),
	_doc_items_longdesc = hoe_longdesc,
	_doc_items_usagehelp = hoe_usagehelp,
	inventory_image = "tnt_plus_uraniumhoe.png",
	wield_scale = mcl_vars.tool_wield_scale,
	on_place = hoe_on_place_function(uses.uranium),
	groups = { tool=1, hoe=1, enchantability=15 },
	tool_capabilities = {
		full_punch_interval = 0.25,
		damage_groups = { fleshy = 4, },
		punch_attack_uses = uses.uranium,
	},
	_repair_material = "tnt_plus:uranium_ingot",
	_mcl_toollike_wield = true,
	_mcl_diggroups = {
		hoey = { speed = 8, level = 5, uses = 2031 }
	},
})


--armor
mcl_armor.register_set({
	name = "uranium",
	descriptions = {
		head = S("Uranium Helmet"),
		torso = S("Uranium Chestplate"),
		legs = S("Uranium Leggings"),
		feet = S("Uranium Boots"),
	},
	durability = 555,
	enchantability = 10,
	points = {
		head = 3,
		torso = 8,
		legs = 6,
		feet = 3,
	},
	toughness = 2,
	craft_material = "tnt_plus:uranium_ingot",
	sound_equip = "mcl_armor_equip_diamond",
	sound_unequip = "mcl_armor_unequip_diamond",
})