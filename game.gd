# Game.gd
# class_name Game
extends Node

@onready var _pause_menu := $InterfaceLayer/PauseMenu as PauseMenu
@onready var _level_root := $LevelRoot
@onready var _player := $Player
@onready var _video_player := $InterfaceLayer/AspectRatioContainer/VideoStreamPlayer

func _ready():
	change_level("res://scenes/levels/level0.tscn")

func change_level(path: String) -> void:
	# 清掉舊關卡
	for child in _level_root.get_children():
		child.queue_free()

	# 載入新關卡
	var new_level = load(path).instantiate()
	_level_root.add_child(new_level)

	# 玩家傳送到 SpawnPoint（如果有）
	var spawn = new_level.get_node_or_null("SpawnPoint")
	if spawn:
		_player.global_position = spawn.global_position

	# 連接新關卡裡所有電腦的 signal
	for comp in new_level.get_tree().get_nodes_in_group("computers"):
		comp.play_video.connect(play_video)
		comp.stop_video.connect(stop_video)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_fullscreen"):
		var mode := DisplayServer.window_get_mode()
		if mode == DisplayServer.WINDOW_MODE_FULLSCREEN or \
				mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		get_tree().root.set_input_as_handled()
	elif event.is_action_pressed(&"toggle_pause"):
		var tree := get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pause_menu.open()
		else:
			_pause_menu.close()
		get_tree().root.set_input_as_handled()

func play_video(path: String):
	_video_player.stream = load(path)
	_video_player.visible = true
	_video_player.play()
	_player.can_control = false
	#_player.set_process_input(false)
	#get_tree().paused = true   # 暫停遊戲
	print("Video playing: ", path)

func stop_video():
	_video_player.stop()
	_video_player.visible = false
	_player.can_control = true
	#_player.set_process_input(true)
	#get_tree().paused = false
	print("Video stopped")
