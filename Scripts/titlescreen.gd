class_name TitleScreen extends Control

func _ready() -> void:
	%StartButton.grab_focus()

func set_input(input: bool) -> void:
	if input:
		$".".set_mouse_filter(Control.MOUSE_FILTER_STOP)
		%StartButton.focus_mode = FOCUS_ALL
		%OptionButton.focus_mode = FOCUS_ALL
		%ExitButton.focus_mode = FOCUS_ALL
	else:
		$".".set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		%StartButton.focus_mode = FOCUS_NONE
		%OptionButton.focus_mode = FOCUS_NONE
		%ExitButton.focus_mode = FOCUS_NONE

func _on_option_button_pressed() -> void:
	%SettingsMenu.open()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_focus_entered() -> void:
	%StartButton.grab_focus()
