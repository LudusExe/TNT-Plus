local function is_valid_ground(name)
    local def = minetest.registered_nodes[name]
    if not def then return false end

    if def.buildable_to then return false end
    if def.drawtype == "plantlike" then return false end
    if minetest.get_item_group(name, "grass") > 0 then return false end

    return true
end
local function atomic_fallout(pos, radius)
    local minp = vector.subtract(pos, radius)
    local maxp = vector.add(pos, radius)

    for x = minp.x, maxp.x do
        for z = minp.z, maxp.z do
            local dx = x - pos.x
            local dz = z - pos.z

            if dx*dx + dz*dz <= radius*radius then
                if math.random() < 0.15 then
                    for y = maxp.y, minp.y, -1 do
                        local p = {x=x, y=y, z=z}
                        local n = minetest.get_node(p).name

                        if n ~= "air" and n ~= "ignore" then
                            if is_valid_ground(n) then
                                local above = {x=x, y=y+1, z=z}
                                if minetest.get_node(above).name == "air" then
                                    minetest.set_node(above, {
                                        name = "tnt_plus:nuclear_waste"
                                    })
                                end
                            end
                            break
                        end
                    end
                end
            end
        end
    end
end



local function atomic_voxel_explosion(pos, radius)
    local minp = vector.subtract(pos, radius)
    local maxp = vector.add(pos, radius)
    local vm = minetest.get_voxel_manip()
    local emin, emax = vm:read_from_map(minp, maxp)
    local area = VoxelArea:new({MinEdge=emin,MaxEdge=emax})
    local data = vm:get_data()

    for z=emin.z,emax.z do
        for y=emin.y,emax.y do
            for x=emin.x,emax.x do
                local dx=x-pos.x
                local dy=y-pos.y
                local dz=z-pos.z
                if dx*dx+dy*dy+dz*dz <= radius*radius then
                    local i=area:index(x,y,z)
                    local cid=data[i]
                    if cid~=c_air and cid~=c_ignore and cid~=c_bedrock then
                        data[i]=c_air
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
    name="tnt_plus:tnt_atomic",
    entity="tnt_plus:tnt_atomic_entity",
    description="Atomic TNT",
    timer=20,
    tiles={
        "tnt_plus_atomic_top.png",
        "tnt_plus_atomic_bottom.png",
        "tnt_plus_atomic_side.png",
        "tnt_plus_atomic_side.png",
        "tnt_plus_atomic_side.png",
        "tnt_plus_atomic_side.png"
    },
    on_explode=function(pos,obj)
    mcl_explosions.explode(pos,60,{fire=true},obj)
    minetest.after(0, function()
        atomic_voxel_explosion(pos,80)
    end)
    minetest.after(1, function()
        atomic_voxel_explosion(pos,120)
    end)
    minetest.after(2, function()
        atomic_fallout(pos,160)
    end)
end
})



minetest.register_node("tnt_plus:nuclear_waste", {
    description = "Nuclear Waste",
    tiles = {"tnt_plus_nuclear_waste.png"},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
    },
    paramtype = "light",
    buildable_to = true,
    walkable = true,
    light_source = 5,
    groups = {crumbly=3, falling_node=1},
})
