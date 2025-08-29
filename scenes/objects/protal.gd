extends Area2D

@export_file("*.tscn") var next_scene_path: String = ""

func _ready():
	body_entered.connect(_on_body_entered)

var triggered = false

func _on_body_entered(body):
	if triggered:
		return
	if body.is_in_group("player") and next_scene_path != "":
		triggered = true
		var game = get_tree().current_scene
		if game.has_method("change_level"):
			game.call_deferred("change_level", next_scene_path)
