
local mod = require 'core/mods'

if note_players == nil then
    note_players = {}
end

local function add_disting_player()
    local player = {
        count = 0
    }

    function player:note_on(note, vel)
        local v_vel = vel * 10
        local v8 = (note - 60)/12        
        crow.ii.disting.note_pitch(note, v8)
        crow.ii.disting.note_velocity(note, v_vel)
    end

    function player:pitch_bend(note, amount)
        local v8 = (note + amount - 60)/12
        crow.ii.disting.note_pitch(note, v8)
    end

    function player:note_off(note)
        crow.ii.disting.note_off(note)
    end

    function player:describe()
        return {
            name = "ex",
            supports_bend = true,
            supports_slew = false,
            modulate_description = "unsupported",
        }
    end

    function player:stop_all()
        -- crow.ii.disting.all_notes_off()
    end

    note_players["ex"] = player
end

mod.hook.register("script_pre_init", "nb ex pre init", function()
    add_disting_player()
end)
