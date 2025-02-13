class_name SettingsMenu extends Control

@onready var tween: Tween

func set_input(input: bool) -> void:
	if input:
		$".".set_mouse_filter(Control.MOUSE_FILTER_STOP)
		%Graphics.focus_mode = FOCUS_ALL
		%Audio.focus_mode = FOCUS_ALL
		%Input.focus_mode = FOCUS_ALL
		%SaveButton.focus_mode = FOCUS_ALL
		%CloseButton.focus_mode = FOCUS_ALL
	else:
		$".".set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		%Graphics.focus_mode = FOCUS_NONE
		%Audio.focus_mode = FOCUS_NONE
		%Input.focus_mode = FOCUS_NONE
		%SaveButton.focus_mode = FOCUS_NONE
		%CloseButton.focus_mode = FOCUS_NONE

func open() -> void:
	$".".show()
	$"../..".set_input(false)
	set_input(true)
	%CloseButton.grab_focus()
	
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property($".", "position:y", $"..".get_theme_constant("margin_top"), 0.5).from(get_viewport_rect().size.y)

func close() -> void:
	$"../..".set_input(true)
	set_input(false)
	%StartButton.grab_focus()
	
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_property($".", "position:y", get_viewport_rect().size.y, 0.5).from_current()
	tween.tween_callback($".".hide)

func save() -> void:
	pass

func _on_close_button_pressed() -> void:
	close()

func _on_save_button_pressed() -> void:
	save()
