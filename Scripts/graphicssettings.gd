extends Control

func _ready() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		%WindowMode.selected = 1
	elif DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS):
		%WindowMode.selected = 2
	else:
		%WindowMode.selected = 0
	
	match DisplayServer.window_get_vsync_mode():
		DisplayServer.VSYNC_DISABLED:
			%VSync.selected = 0
		DisplayServer.VSYNC_ENABLED:
			%VSync.selected = 1
		DisplayServer.VSYNC_ADAPTIVE:
			%VSync.selected = 2
		DisplayServer.VSYNC_MAILBOX:
			%VSync.selected = 3
	
	%TAA.button_pressed = ProjectSettings.get("rendering/anti_aliasing/quality/use_taa")
	
	match ProjectSettings.get("rendering/anti_aliasing/quality/msaa_2d"):
		RenderingServer.VIEWPORT_MSAA_DISABLED:
			%MSAA.selected = 0
		RenderingServer.VIEWPORT_MSAA_2X:
			%MSAA.selected = 1
		RenderingServer.VIEWPORT_MSAA_4X:
			%MSAA.selected = 2
		RenderingServer.VIEWPORT_MSAA_8X:
			%MSAA.selected = 3
	
	%FXAA.button_pressed = ProjectSettings.get("rendering/anti_aliasing/quality/screen_space_aa")

func _on_window_mode_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP, false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP, true)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP, false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _on_v_sync_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		1:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		2:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
		3:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)

func _on_taa_toggled(toggled_on: bool) -> void:
	RenderingServer.viewport_set_use_taa(get_viewport().get_viewport_rid(), toggled_on)

func _on_msaa_item_selected(index: int) -> void:
	match index:
		0:
			RenderingServer.viewport_set_msaa_2d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_DISABLED)
			RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_DISABLED)
		1:
			RenderingServer.viewport_set_msaa_2d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_2X)
			RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_2X)
		2:
			RenderingServer.viewport_set_msaa_2d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_4X)
			RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_4X)
		3:
			RenderingServer.viewport_set_msaa_2d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_8X)
			RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_MSAA_8X)

func _on_fxaa_toggled(toggled_on: bool) -> void:
	if toggled_on:
		RenderingServer.viewport_set_screen_space_aa(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_SCREEN_SPACE_AA_FXAA)
	else:
		RenderingServer.viewport_set_screen_space_aa(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_SCREEN_SPACE_AA_DISABLED)
