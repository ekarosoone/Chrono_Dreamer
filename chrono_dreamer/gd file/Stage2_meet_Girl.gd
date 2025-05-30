extends Sprite2D  # 또는 Area2D로 붙여도 됨

@export var next_stage_path: String = "res://tscnfile/STAGE3_gocave.tscn"

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file(next_stage_path)
