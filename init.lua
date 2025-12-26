local INDESTRUCTIBLE = {
    ["mcl_core:bedrock"] = true,
}

local function register_tnt(def)
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

local normal_tnts = {
    {id="x2", r=7},
    {id="x5", r=15},
    {id="x10", r=30},
}

for _, t in ipairs(normal_tnts) do
    register_tnt({
        name = "tnt_plus:tnt_"..t.id,
        entity = "tnt_plus:tnt_"..t.id.."_entity",
        description = "TNT "..t.id:upper(),
        timer = 4,
        tiles = {
            "tnt_plus"..t.id.."top.png",
            "tnt_plus"..t.id.."side.png",
            "tnt_plus"..t.id.."bottom.png",
        },
        on_explode = function(pos, obj)
            mcl_explosions.explode(pos, t.r, {}, obj)
        end
    })
end

local function destroy_sphere(pos, radius, max_nodes)
    local destroyed = 0
    local step = 16

    for x=-radius, radius, step do
        for y=-radius, radius, step do
            for z=-radius, radius, step do
                local minp = vector.add(pos, {x=x,y=y,z=z})
                local maxp = vector.add(minp, {x=step-1,y=step-1,z=step-1})

                minetest.load_area(minp, maxp)

                local nodes = minetest.find_nodes_in_area(minp, maxp, {})
                for _, p in ipairs(nodes) do
                    if destroyed >= max_nodes then return end
                    local dx = p.x-pos.x
                    local dy = p.y-pos.y
                    local dz = p.z-pos.z
                    if dx*dx+dy*dy+dz*dz <= radius*radius then
                        local n = minetest.get_node(p).name
                        if n ~= "air" and n ~= "ignore"
                        and not INDESTRUCTIBLE[n]
                        and not minetest.is_protected(p, "") then
                            minetest.set_node(p, {name="air"})
                            destroyed = destroyed + 1
                        end
                    end
                end
            end
        end
    end
end

register_tnt({
    name = "tnt_plus:tnt_100",
    entity = "tnt_plus:tnt_100_entity",
    description = "TNT 100X",
    timer = 4,
    tiles = {
        "tnt_plus_100top.png",
        "tnt_plus_100side.png",
        "tnt_plus_100bottom.png",
    },
    on_explode = function(pos, obj)
        destroy_sphere(pos, 100, 150000)
        mcl_explosions.explode(pos, 20, {}, obj)
    end
})

register_tnt({
    name = "tnt_plus:tnt_500",
    entity = "tnt_plus:tnt_500_entity",
    description = "TNT 500X",
    timer = 6,
    tiles = {
        "tnt_plus_500top.png",
        "tnt_plus_500side.png",
        "tnt_plus_500bottom.png",
    },
    on_explode = function(pos, obj)
        minetest.after(0, function()
            destroy_sphere(pos, 500, 300000)
        end)
        mcl_explosions.explode(pos, 30, {}, obj)
    end
})

minetest.register_entity("tnt_plus:blackhole_core", {
    physical = false,
    pointable = false,
    visual = "sprite",
    textures = {"tnt_blackhole.png"},
    visual_size = {x=2, y=2},

    timer = 0,
    lifetime = 8,
    radius = 160,
    max_force = 60,

    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        if self.timer >= self.lifetime then
            self.object:remove()
            return
        end

        local pos = self.object:get_pos()
        for _, obj in ipairs(minetest.get_objects_inside_radius(pos, self.radius)) do
            if obj ~= self.object then
                local p = obj:get_pos()
                if p then
                    local dir = vector.direction(p, pos)
                    local dist = math.max(vector.distance(p, pos), 1)
                    local force = math.min(self.max_force / dist, self.max_force)
                    obj:add_velocity(vector.multiply(dir, force))
                end
            end
        end
    end
})

local c_air     = minetest.get_content_id("air")
local c_ignore  = minetest.get_content_id("ignore")
local c_bedrock = minetest.get_content_id("mcl_core:bedrock")
local c_barrier = minetest.get_content_id("mcl_core:barrier")

local function blackhole_voxel_destruction(pos, radius)
    local minp = vector.subtract(pos, radius)
    local maxp = vector.add(pos, radius)

    local vm = minetest.get_voxel_manip()
    local emin, emax = vm:read_from_map(minp, maxp)

    local area = VoxelArea:new({ MinEdge = emin, MaxEdge = emax })
    local data = vm:get_data()

    for z = emin.z, emax.z do
        for y = emin.y, emax.y do
            for x = emin.x, emax.x do
                local dx = x - pos.x
                local dy = y - pos.y
                local dz = z - pos.z

                if dx*dx + dy*dy + dz*dz <= radius*radius then
                    local i = area:index(x, y, z)
                    local cid = data[i]

                    if cid ~= c_air
                    and cid ~= c_ignore
                    and cid ~= c_bedrock
                    and cid ~= c_barrier then
                        data[i] = c_air
                    end
                end
            end
        end
    end

    vm:set_data(data)
    vm:write_to_map()
    vm:update_map()
end

register_tnt({
    name = "tnt_plus:tnt_blackhole",
    entity = "tnt_plus:tnt_blackhole_entity",
    description = "Black Hole TNT",
    timer = 10,

    tiles = {
        "tnt_bh_top.png",
        "tnt_bh_top.png",
        "tnt_bh_side.png",
        "tnt_bh_side.png",
        "tnt_bh_side.png",
        "tnt_bh_side.png",
    },

    on_explode = function(pos, obj)
        mcl_explosions.explode(pos, 50, {}, obj)
        minetest.after(0, function()
            blackhole_voxel_destruction(pos, 140)
        end)
        minetest.after(0.2, function()
            minetest.add_entity(pos, "tnt_plus:blackhole_core")
        end)
    end
})

local function atomic_voxel_explosion(pos, radius)
    local minp = vector.subtract(pos, radius)
    local maxp = vector.add(pos, radius)

    local vm = minetest.get_voxel_manip()
    local emin, emax = vm:read_from_map(minp, maxp)

    local area = VoxelArea:new({ MinEdge = emin, MaxEdge = emax })
    local data = vm:get_data()

    for z = emin.z, emax.z do
        for y = emin.y, emax.y do
            for x = emin.x, emax.x do
                local dx = x - pos.x
                local dy = y - pos.y
                local dz = z - pos.z

                if dx*dx + dy*dy + dz*dz <= radius*radius then
                    local i = area:index(x, y, z)
                    local cid = data[i]

                    if cid ~= c_air
                    and cid ~= c_ignore
                    and cid ~= c_bedrock
                    and cid ~= c_barrier then
                        data[i] = c_air
                    end
                end
            end
        end
    end

    vm:set_data(data)
    vm:write_to_map()
    vm:update_map()
end

register_tnt({
    name = "tnt_plus:tnt_atomic",
    entity = "tnt_plus:tnt_atomic_entity",
    description = "Atomic TNT",
    timer = 10,

    tiles = {
        "tnt_atomic_top.png",
        "tnt_atomic_top.png",
        "tnt_atomic_side.png",
        "tnt_atomic_side.png",
        "tnt_atomic_side.png",
        "tnt_atomic_side.png",
    },

    on_explode = function(pos, obj)
        mcl_explosions.explode(pos, 60, { fire = true }, obj)
        minetest.after(0, function()
            atomic_voxel_explosion(pos, 120)
        end)
        minetest.after(0.8, function()
            mcl_explosions.explode(pos, 25, {}, obj)
        end)
    end
})

register_tnt({
    name = "tnt_plus:tnt_lava",
    entity = "tnt_plus:tnt_lava_entity",
    description = "Lava TNT",
    timer = 4,
    tiles = {
        "tnt_lava_top.png",
        "tnt_lava_side.png",
        "tnt_lava_bottom.png",
    },
    on_explode = function(pos, obj)
        mcl_explosions.explode(pos, 6, {}, obj)
        for _, p in ipairs(minetest.find_nodes_in_area(
            vector.subtract(pos, 2),
            vector.add(pos, 2),
            {"air"}
        )) do
            if math.random() < 0.3 then
                minetest.set_node(p, {name="mcl_core:lava_source"})
            end
        end
    end
})

register_tnt({
    name = "tnt_plus:tnt_water",
    entity = "tnt_plus:tnt_water_entity",
    description = "Water TNT",
    timer = 4,
    tiles = {
        "tnt_water_top.png",
        "tnt_water_side.png",
        "tnt_water_bottom.png",
    },
    on_explode = function(pos, obj)
        for _, p in ipairs(minetest.find_nodes_in_area(
            vector.subtract(pos, 2),
            vector.add(pos, 2),
            {"air"}
        )) do
            if math.random() < 0.3 then
                minetest.set_node(p, {name="mcl_core:water_source"})
            end
        end
    end
})

register_tnt({
    name = "tnt_plus:tnt_flat",
    entity = "tnt_plus:tnt_flat_entity",
    description = "Flat TNT",
    timer = 4,
    tiles = {
        "tnt_flat_top.png",
        "tnt_flat_side.png",
        "tnt_flat_bottom.png",
    },

    on_explode = function(pos, obj)
        local radius = 20
        local y_target = pos.y
        local max_height = y_target + 3

        for x = pos.x - radius, pos.x + radius do
            for z = pos.z - radius, pos.z + radius do
                for y = y_target, max_height do
                    local p = {x=x, y=y, z=z}
                    local n = minetest.get_node(p).name
                    if n ~= "air" and n ~= "ignore" and not minetest.is_protected(p, "") then
                        minetest.set_node(p, {name="air"})
                    end
                end
            end
        end

        mcl_explosions.explode(pos, 1, {}, obj)
    end,
})

register_tnt({
    name = "tnt_plus:tnt_vertical",
    entity = "tnt_plus:tnt_vertical_entity",
    description = "Vertical TNT",
    timer = 4,
    tiles = {
        "tnt_vertical_top.png",
        "tnt_vertical_side.png",
        "tnt_vertical_bottom.png",
    },

    on_explode = function(pos, obj)
        local depth = 50
        local height = 50
        local radius = 2

        for y=pos.y-depth,pos.y+height do
            for x=pos.x-radius,pos.x+radius do
                for z=pos.z-radius,pos.z+radius do
                    local p = {x=x, y=y, z=z}
                    local n = minetest.get_node(p).name
                    if n ~= "air" and n ~= "ignore" and not minetest.is_protected(p, "") then
                        minetest.set_node(p, {name="air"})
                    end
                end
            end
        end

        mcl_explosions.explode(pos, 1, {}, obj)
    end,
})
