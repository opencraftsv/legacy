local S = (default and default.get_translator) or function(s) return s end
local LIGHT_MAX = 14

local function on_flood(pos, oldnode, newnode)
        minetest.add_item(pos, ItemStack("default:torch 1"))
        local nodedef = minetest.registered_items[newnode.name]
        if not (nodedef and nodedef.groups and nodedef.groups.igniter and nodedef.groups.igniter > 0) then
                minetest.sound_play("default_cool_lava", {
                        pos = pos,
                        max_hear_distance = 16,
                        gain = 0.07,
                }, true)
        end
        return false
end

minetest.register_node("default:torch", {
        description = S("Torch"),
        drawtype = "torchlike",
        tiles = {
                {
                        name = "default_torch_on_floor_animated.png",
                        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3},
                },
                {
                        name = "default_torch_on_ceiling_animated.png",
                        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3},
                },
                {
                        name = "default_torch_on_wall_animated.png",
                        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3},
                },
        },
        inventory_image = "default_torch_on_floor.png",
        wield_image = "default_torch_on_floor.png",
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        walkable = false,
        light_source = LIGHT_MAX - 1,
        selection_box = {
                type = "wallmounted",
                wall_top = {-0.1, -0.1, -0.1, 0.1, 0.5, 0.1},
                wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.1, 0.1},
                wall_side = {-0.5, -0.3, -0.1, -0.2, 0.3, 0.1},
        },
        groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, hot = 2, torch = 1},
        legacy_wallmounted = true,
        sounds = default.node_sound_wood_defaults(),
        floodable = true,
        on_flood = on_flood,
        on_rotate = false,
})

minetest.register_craft({
        output = "default:torch 4",
        recipe = {
                {"default:coal_lump"},
                {"group:stick"},
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "default:torch",
        burntime = 4,
})
