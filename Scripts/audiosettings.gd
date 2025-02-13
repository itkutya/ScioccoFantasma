extends Control

func _ready() -> void:
	%GlobalSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	%GameSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Game")))
	%SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	%MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	
	%GlobalValue.text = str(%GlobalSlider.value * 100.0)
	%GameValue.text = str(%GameSlider.value * 100.0)
	%SFXValue.text = str(%SFXSlider.value * 100.0)
	%MusicValue.text = str(%MusicSlider.value * 100.0)
	
func _on_global_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
	%GlobalValue.text = str(value * 100.0)

func _on_game_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Game"), linear_to_db(value))
	%GameValue.text = str(value * 100.0)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	%SFXValue.text = str(value * 100.0)

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
	%MusicValue.text = str(value * 100.0)
