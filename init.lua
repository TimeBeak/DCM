activate = true

minetest.register_chatcommand(
    "death",
    {
        description = "Enable or disable death coordinates",
        params = "<true> | <false>",
        privs = {ban = true},
        func = function(name, param)
            if param == "true" then
                activate = true
                minetest.chat_send_all(minetest.colorize("#00FF00", "*** [Server]: Death coordinates are enabled!"))

                music =
                    minetest.sound_play(
                    "notify",
                    {
                        loop = false,
                        gain = 1.0
                    }
                )
            end

            if param == "false" then
                activate = false

                minetest.chat_send_all(minetest.colorize("#FF0000", "*** [Server]: Death coordinates are disabled!"))

                music =
                    minetest.sound_play(
                    "notify",
                    {
                        loop = false,
                        gain = 1.0
                    }
                )
            end
        end
    }
)

minetest.register_on_dieplayer(
    function(player)
        if activate == true then
            local pname = player:get_player_name()
            local pos = player:getpos()
            pos.x = math.floor(pos.x)
            pos.y = math.floor(pos.y)
            pos.z = math.floor(pos.z)
            minetest.chat_send_player(
                pname,
                core.get_color_escape_sequence("#FF0000") ..
                    "*** [Server] - Last Dead At: " .. pos.x .. ", " .. pos.y .. ", " .. pos.z
            )

            music =
                minetest.sound_play(
                "die",
                {
                    loop = false,
                    gain = 1.0
                }
            )
        end
    end
)
