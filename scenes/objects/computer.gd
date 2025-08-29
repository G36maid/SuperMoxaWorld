extends Area2D

@export var video_path: String = "res://asset/Video/Ryan_finale.ogv"

@onready var interaction_label = $Label
var player_near = false

signal play_video(path: String)
signal stop_video()

func _ready():
	interaction_label.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	add_to_group("computers")   # 自動加 group

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_near = true
		interaction_label.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_near = false
		interaction_label.visible = false

func _unhandled_input(event):
	if player_near:
		if event.is_action_pressed("interact"): # E
			emit_signal("play_video", video_path)
		elif event.is_action_pressed("ui_quit"): # Q
			emit_signal("stop_video")
