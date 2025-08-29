extends Area2D

@export_file("*.tscn") var next_scene_path: String = ""

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player") and next_scene_path != "":
		# 找到 Main 並叫它換地圖
		var main = get_tree().current_scene
		if main.has_method("change_level"):
			main.change_level(next_scene_path)
