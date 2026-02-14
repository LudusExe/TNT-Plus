local BH_QUEUE = {}
local CHUNK = 16

local function chunk_pos(p)
    return {
        x = math.floor(p.x / CHUNK) * CHUNK,
        y = math.floor(p.y / CHUNK) * CHUNK,
        z = math.floor(p.z / CHUNK) * CHUNK
    }
end

local function schedule_chunks_in_sphere(center, radius)
    local r2 = radius * radius
    local min = chunk_pos(vector.subtract(center, radius))
    local max = chunk_pos(vector.add(center, radius))

    for x = min.x, max.x, CHUNK do
        for y = min.y, max.y, CHUNK do
            for z = min.z, max.z, CHUNK do
                local cx = x + CHUNK / 2
                local cy = y + CHUNK / 2
                local cz = z + CHUNK / 2
                local dx = cx - center.x
                local dy = cy - center.y
                local dz = cz - center.z

                if (dx*dx + dy*dy + dz*dz) <= r2 then
                    table.insert(BH_QUEUE, {x=x, y=y, z=z})
                end
            end
        end
    end
end

minetest.register_globalstep(function()
    local chunks_per_tick = 2 -- tecnically i can go further, but mobile phones will explode

    for i = 1, chunks_per_tick do
        local c = table.remove(BH_QUEUE)
        if not c then return end

        for x = c.x, c.x + CHUNK - 1 do
            for y = c.y, c.y + CHUNK - 1 do
                for z = c.z, c.z + CHUNK - 1 do
                    local p = {x=x, y=y, z=z}
                    local node = minetest.get_node_or_nil(p)
                    if node
                    and node.name ~= "air"
                    and node.name ~= "ignore"
                    and node.name ~= "mcl_core:bedrock"
                    and node.name ~= "mcl_core:barrier" then
                        minetest.set_node(p, {name="air"})
                    end
                end
            end
        end
    end
end)


minetest.register_entity("tnt_plus:blackhole_core", {
    physical = false,
    visual = "sprite",
    textures = {"blank.png"},
    visual_size = {x = 0, y = 0},
    collisionbox = {0,0,0,0,0,0},
    pointable = false,
    on_activate = function(self, staticdata, dtime_s)
        self.timer = 0
        self.lifetime = 40
        self.radius = 150
        self.initialized = false
    end,

    
    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        if self.timer > self.lifetime then
            self.object:remove()
            return
        end

        local pos = self.object:get_pos()
        if not pos then return end
        if not self.initialized then
            schedule_chunks_in_sphere(pos, self.radius)
            self.initialized = true
        end

        for _, obj in ipairs(minetest.get_objects_inside_radius(pos, self.radius)) do
            if obj ~= self.object then
                local p = obj:get_pos()
                if p then
                    local dist = math.max(vector.distance(p, pos), 1)
                    local dir = vector.direction(p, pos)
                    local force = math.min(300 / dist, 8)
                    obj:add_velocity(vector.multiply(dir, force))
                end
            end
        end
    end
})

register_tnt({
    name = "tnt_plus:tnt_blackhole",
    entity = "tnt_plus:tnt_blackhole_entity",
    description = "Black Hole TNT",
    timer = 12,

    tiles = {
        "tnt_plus_bh_top.png",
        "tnt_plus_bh_bottom.png",
        "tnt_plus_bh_side.png",
        "tnt_plus_bh_side.png",
        "tnt_plus_bh_side.png",
        "tnt_plus_bh_side.png"
    },

    on_explode = function(pos, obj)
        mcl_explosions.explode(pos, 50, {}, obj)
        minetest.after(0.3, function()
            minetest.add_entity(pos, "tnt_plus:blackhole_core")
        end)
    end
})
