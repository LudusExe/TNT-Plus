local function freeze_sphere(pos, radius)
    for x = pos.x - radius, pos.x + radius do
        for y = pos.y - radius, pos.y + radius do
            for z = pos.z - radius, pos.z + radius do
                local dx = x - pos.x
                local dy = y - pos.y
                local dz = z - pos.z

                if dx*dx + dy*dy + dz*dz <= radius*radius then
                    minetest.set_node(
                        {x = x, y = y, z = z},
                        {name = "mcl_core:ice"}
                    )
                end
            end
        end
    end
end
register_tnt({
    name = "tnt_plus:tnt_freeze",
    entity = "tnt_plus:tnt_freeze_entity",
    description = "Freeze TNT",
    timer = 10,
    tiles = {
        "tnt_plus_freeze_top.png",
        "tnt_plus_freeze_bottom.png",
        "tnt_plus_freeze_side.png",
        "tnt_plus_freeze_side.png",
        "tnt_plus_freeze_side.png",
        "tnt_plus_freeze_side.png"
    },
    on_explode = function(pos)
        freeze_sphere(pos, 10)
    end
})


register_tnt({
    name="tnt_plus:tnt_lava",
    entity="tnt_plus:tnt_lava_entity",
    description="Lava TNT",
    timer=4,
    tiles={
        "tnt_plus_lava_top.png",
        "tnt_plus_lava_bottom.png",
        "tnt_plus_lava_side.png",
        "tnt_plus_lava_side.png",
        "tnt_plus_lava_side.png",
        "tnt_plus_lava_side.png"
    },
    on_explode=function(pos,obj)
        mcl_explosions.explode(pos,6,{},obj)
        for _,p in ipairs(minetest.find_nodes_in_area(
            vector.subtract(pos,2),
            vector.add(pos,2),
            {"air"}
        )) do
            if math.random()<0.3 then
                minetest.set_node(p,{name="mcl_core:lava_source"})
            end
        end
    end
})

register_tnt({
    name="tnt_plus:tnt_water",
    entity="tnt_plus:tnt_water_entity",
    description="Water TNT",
    timer=4,
    tiles={
        "tnt_plus_water_top.png",
        "tnt_plus_water_bottom.png",
        "tnt_plus_water_side.png",
        "tnt_plus_water_side.png",
        "tnt_plus_water_side.png",
        "tnt_plus_water_side.png"
    },
    on_explode=function(pos)
        for _,p in ipairs(minetest.find_nodes_in_area(
            vector.subtract(pos,2),
            vector.add(pos,2),
            {"air"}
        )) do
            if math.random() < 0.3 then
                minetest.set_node(p,{name="mcl_core:water_source"})
            end
        end
    end
})


register_tnt({
    name="tnt_plus:tnt_flat",
    entity="tnt_plus:tnt_flat_entity",
    description="Flat TNT",
    timer=4,
    tiles={
        "tnt_plus_fl_top.png",
        "tnt_plus_fl_bottom.png",
        "tnt_plus_fl_side.png",
        "tnt_plus_fl_side.png",
        "tnt_plus_fl_side.png",
        "tnt_plus_fl_side.png"
    },
    on_explode=function(pos,obj)
        local r, h = 20, 3
        for x=pos.x-r,pos.x+r do
            for z=pos.z-r,pos.z+r do
                for y=pos.y,pos.y+h do
                    local p = {x=x,y=y,z=z}
                    local n = minetest.get_node(p).name
                    if n ~= "air"
                    and n ~= "ignore"
                    and not INDESTRUCTIBLE[n] then
                        minetest.set_node(p,{name="air"})
                    end
                end
            end
        end
        mcl_explosions.explode(pos,1,{},obj)
    end
})

register_tnt({
    name="tnt_plus:tnt_flat_mount",
    entity="tnt_plus:tnt_flat_mount_entity",
    description="Flat Mountain TNT",
    timer=4,
    tiles={
        "tnt_plus_flmount_top.png",
        "tnt_plus_flmount_bottom.png",
        "tnt_plus_flmount_side.png",
        "tnt_plus_flmount_side.png",
        "tnt_plus_flmount_side.png",
        "tnt_plus_flmount_side.png"
    },
   on_explode=function(pos,obj)
        local r, h = 40, 80
        for x=pos.x-r,pos.x+r do
            for z=pos.z-r,pos.z+r do
                for y=pos.y,pos.y+h do
                    local p = {x=x,y=y,z=z}
                    local n = minetest.get_node(p).name
                    if n ~= "air"
                    and n ~= "ignore"
                    and not INDESTRUCTIBLE[n] then
                        minetest.set_node(p,{name="air"})
                    end
                end
            end
        end
        mcl_explosions.explode(pos,1,{},obj)
    end
})

register_tnt({
    name="tnt_plus:tnt_vertical",
    entity="tnt_plus:tnt_vertical_entity",
    description="Vertical TNT",
    timer=4,
    tiles={
        "tnt_plus_vertical_top.png",
        "tnt_plus_vertical_bottom.png",
        "tnt_plus_vertical_side.png",
        "tnt_plus_vertical_side.png",
        "tnt_plus_vertical_side.png",
        "tnt_plus_vertical_side.png"
    },
    on_explode=function(pos,obj)
        for y=pos.y-50,pos.y+50 do
            for x=pos.x-2,pos.x+2 do
                for z=pos.z-2,pos.z+2 do
                    local p={x=x,y=y,z=z}
                    local n=minetest.get_node(p).name
                    if n~="air" and n~="ignore"
                    and not INDESTRUCTIBLE[n] then
                        minetest.set_node(p,{name="air"})
                    end
                end
            end
        end
        mcl_explosions.explode(pos,1,{},obj)
    end
})


register_tnt({
    name="tnt_plus:tnt_tent",
    entity="tnt_plus:tnt_tent_entity",
    description="Tent TNT",
    timer=4,
    tiles={
        "tnt_plus_tent_top.png",
        "tnt_plus_tent_bottom.png",
        "tnt_plus_tent_side.png",
        "tnt_plus_tent_side.png",
        "tnt_plus_tent_side.png",
        "tnt_plus_tent_side.png"
    },
    on_explode=function(pos)
        place_schematic("tnt_plus_tent.mts",pos)
    end
})


register_tnt({
    name="tnt_plus:tnt_house",
    entity="tnt_plus:tnt_house_entity",
    description="House TNT",
    timer=4,
    tiles={
        "tnt_plus_house_top.png",
        "tnt_plus_house_bottom.png",
        "tnt_plus_house_side.png",
        "tnt_plus_house_side.png",
        "tnt_plus_house_side.png",
        "tnt_plus_house_side.png"
    },
    on_explode=function(pos)
        place_schematic("tnt_plus_house.mts",pos)
    end
})


register_tnt({
    name="tnt_plus:tnt_rain",
    entity="tnt_plus:tnt_rain_entity",
    description="Rain TNT",
    timer=8,
    tiles={
        "tnt_plus_rain_top.png",
        "tnt_plus_rain_bottom.png",
        "tnt_plus_rain_side.png",
        "tnt_plus_rain_side.png",
        "tnt_plus_rain_side.png",
        "tnt_plus_rain_side.png"
    },
    on_explode=function(pos,obj)
        for i=1,40 do
            local p={
                x=pos.x+math.random(-15,15),
                y=pos.y+120,
                z=pos.z+math.random(-15,15)
            }
            minetest.add_entity(p,"tnt_plus:tnt_water_entity")
        end
        mcl_explosions.explode(pos,3,{},obj)
    end
})



local function find_ground(pos, max_depth)
    local p = vector.new(pos)
    for i = 1, max_depth do
        p.y = p.y - 1
        local n = minetest.get_node(p).name
        if n ~= "air" and n ~= "ignore" then
            return p
        end
    end
end
register_tnt({
    name="tnt_plus:tnt_air",
    entity="tnt_plus:tnt_air_entity",
    description="Airstrike TNT",
    timer=8,
    tiles={
        "tnt_plus_air_top.png",
        "tnt_plus_air_bottom.png",
        "tnt_plus_air_side.png",
        "tnt_plus_air_side.png",
        "tnt_plus_air_side.png",
        "tnt_plus_air_side.png"
    },
    on_explode=function(pos,obj)
        for w=0,9 do
            minetest.after(w,function()
                for i=1,100 do
                    local target={
                        x=pos.x+math.random(-80,80),
                        y=pos.y+80,
                        z=pos.z+math.random(-80,80)
                    }
                    local g=find_ground(target,150)
                    if g then
                        minetest.add_entity(
                            vector.add(g,{x=0,y=80,z=0}),
                            "tnt_plus:tnt_x100_entity"
                        )
                    end
                end
            end)
        end
        mcl_explosions.explode(pos,4,{},obj)
    end
})

register_tnt({
    name="tnt_plus:tnt_mob",
    entity="tnt_plus:tnt_mob_entity",
    description="Mob TNT",
    timer=6,
    tiles={
        "tnt_plus_mob_top.png",
        "tnt_plus_mob_bottom.png",
        "tnt_plus_mob_side.png",
        "tnt_plus_mob_side.png",
        "tnt_plus_mob_side.png",
        "tnt_plus_mob_side.png"
    },
    on_explode=function(pos,obj)
        local mobs={
            "mobs_mc:zombie",
            "mobs_mc:skeleton",         --banging skeleton arrgh
            "mobs_mc:creeper",
            "mobs_mc:enderman",
        }
        for i=1,40 do
            local p={
                x=pos.x+math.random(-10,10),
                y=pos.y+2,
                z=pos.z+math.random(-10,10)
            }
            minetest.add_entity(p,mobs[math.random(#mobs)])
        end
        mcl_explosions.explode(pos,4,{},obj)
    end
})