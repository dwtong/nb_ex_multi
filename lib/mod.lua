local mod = require 'core/mods'
local menu = require("nb_ex/lib/menu")
local data_file = _path.data .. mod.this_name .. "/mod.state"
local device_count

if note_players == nil then
    note_players = {}
end

local function player_name(device_index)
    if device_count == 1 then
        return "ex"
    end
    return string.format("ex (%d)", device_index)
end

local function add_disting_player(device_index)
    local player = {
        count = 0,
        name = player_name(device_index),
    }

    function player:note_on(note, vel)
        local v_vel = vel * 10
        local v8 = (note - 60)/12
        crow.ii.disting[device_index].note_pitch(note, v8)
        crow.ii.disting[device_index].note_velocity(note, v_vel)
    end

    function player:pitch_bend(note, amount)
        local v8 = (note + amount - 60)/12
        crow.ii.disting[device_index].note_pitch(note, v8)
    end

    function player:note_off(note)
        crow.ii.disting[device_index].note_off(note)
    end

    function player:describe()
        return {
            name = player.name,
            supports_bend = true,
            supports_slew = false,
            modulate_description = "unsupported",
        }
    end

    function player:stop_all()
        -- crow.ii.disting[device_index].all_notes_off()
    end

    note_players[player_name(device_index)] = player
end

mod.hook.register("script_pre_init", "nb ex pre init", function()
    if util.file_exists(data_file) then
        device_count = tab.load(data_file).device_count
    else
        device_count = 1
    end

    for device = 1, device_count do
        add_disting_player(device)
    end
end)

mod.menu.register(mod.this_name, menu)
