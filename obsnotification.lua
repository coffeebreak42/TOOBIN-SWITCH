local snd = require('playsound')

o = obslua
next_scene = ""
PROP_START_AUDIO_FILEPATH = script_path() .. "defaultstart.wav"
PROP_STOP_AUDIO_FILEPATH = script_path() .. "defaultstop.wav"

function script_description()
	return "Play a notification sound when starting or stopping recording or streaming.\n> Switches scene to livestream warning scene"
end

function script_load()
    -- snd.playsound(PROP_START_AUDIO_FILEPATH)

    o.obs_frontend_add_event_callback(obs_frontend_callback)
end

function script_unload()
    -- snd.playsound(PROP_STOP_AUDIO_FILEPATH)
end

function obs_frontend_callback(event, private_data)
    if event == o.OBS_FRONTEND_EVENT_RECORDING_STARTED or event == o.OBS_FRONTEND_EVENT_STREAMING_STARTED then
        snd.playsound(PROP_START_AUDIO_FILEPATH)
    	if event == o.OBS_FRONTEND_EVENT_STREAMING_STARTED then
		source = o.obs_get_source_by_name(next_scene)
		o.obs_source_release(source)
		o.obs_frontend_set_current_scene(source)
    	end	
    elseif event == o.OBS_FRONTEND_EVENT_RECORDING_STOPPED or event == o.OBS_FRONTEND_EVENT_STREAMING_STOPPED then
        snd.playsound(PROP_STOP_AUDIO_FILEPATH)
    end
end

function script_properties()
    local AUDIO_FILTER = "WAV files (*.wav)"

    local p = o.obs_properties_create()

    o.obs_properties_add_path(p, "startaudio", "Start sound",
        o.OBS_PATH_FILE,
        AUDIO_FILTER,
        nil
    )

    o.obs_properties_add_path(p, "stopaudio", "Stop sound",
        o.OBS_PATH_FILE,
        AUDIO_FILTER,
        nil
    )
    local t = o.obs_properties_add_list(p, "next_scene", "Livestream Warning Scene", o.OBS_COMBO_TYPE_EDITABLE, o.OBS_COMBO_FORMAT_STRING)
    local scenes = o.obs_frontend_get_scene_names()
	if scenes ~= nil then
		for _, scene in ipairs(scenes) do
			o.obs_property_list_add_string(t, scene, scene)
		end
		o.bfree(scene)
	end
    return p
end

function script_defaults(s)
    o.obs_data_set_default_string(s, "startaudio", PROP_START_AUDIO_FILEPATH)
    o.obs_data_set_default_string(s, "stopaudio", PROP_STOP_AUDIO_FILEPATH)
    o.obs_data_set_default_string(s, "selectscene", next_scene)
end

function script_update(s)
    PROP_START_AUDIO_FILEPATH = o.obs_data_get_string(s, "startaudio")
    PROP_STOP_AUDIO_FILEPATH = o.obs_data_get_string(s, "stopaudio")
    next_scene = o.obs_data_get_string(s, "next_scene")
end
