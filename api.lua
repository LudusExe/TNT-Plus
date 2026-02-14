local modpath = minetest.get_modpath(minetest.get_current_modname())

function place_schematic(name, pos)
    minetest.place_schematic(
        vector.subtract(pos, {x=5,y=0,z=5}),
        modpath .. "/schematics/" .. name,
        "0",
        nil,
        true
    )
end

function register_tnt(def)
    minetest.register_node(def.name, {
        description = def.description,
        tiles = def.tiles,
        groups = { dig_immediate = 3, tnt = 1 },
        is_ground_content = false,

        on_blast = function(pos)
            minetest.remove_node(pos)
            minetest.add_entity(pos, def.entity)
        end,

        _on_ignite = function(_, pointed)
            minetest.remove_node(pointed.under)
            minetest.add_entity(pointed.under, def.entity)
            return true
        end,

        mesecons = {
            effector = {
                action_on = function(pos)
                    minetest.remove_node(pos)
                    minetest.add_entity(pos, def.entity)
                end
            }
        }
    })

    minetest.register_entity(def.entity, {
        physical = true,
        collisionbox = {-0.5,-0.5,-0.5,0.5,0.5,0.5},
        visual = "cube",
        textures = def.tiles,
        timer = 0,

        on_activate = function(self)
            self.object:set_velocity({x=0,y=2,z=0})
            self.object:set_acceleration({x=0,y=-10,z=0})
            self.object:set_armor_groups({immortal=1})
        end,
        on_step = function(self, dtime)
            self.timer = self.timer + dtime
            if self.timer >= def.timer then
                def.on_explode(self.object:get_pos(), self.object)
                self.object:remove()
            end
        end,
    })
end
