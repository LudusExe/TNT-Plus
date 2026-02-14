local normal_tnts = {               --"BOMBA E IL MOVIMENTO SENXUAL!!" un gamer saggio
    {id="x2", r=7},
    {id="x5", r=15},
    {id="x20", r=30},
    {id="x100", r=60},
    {id="x500", r=100},
}

for _, t in ipairs(normal_tnts) do
    register_tnt({
        name = "tnt_plus:tnt_"..t.id,
        entity = "tnt_plus:tnt_"..t.id.."_entity",
        description = "TNT "..t.id:upper(),
        timer = 4,
        tiles = {
            "tnt_plus"..t.id.."top.png",
            "tnt_plus"..t.id.."bottom.png",
            "tnt_plus"..t.id.."side.png",
            "tnt_plus"..t.id.."side.png",
            "tnt_plus"..t.id.."side.png",
            "tnt_plus"..t.id.."side.png"
        },
        on_explode = function(pos, obj)
            mcl_explosions.explode(pos, t.r, {}, obj)
        end
    })
end
