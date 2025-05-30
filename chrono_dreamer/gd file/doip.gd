extends Control

@onready var name_field = $NameField

func _ready():
	name_field.text_submitted.connect(_on_name_submitted)

func _on_name_submitted(text):
	var player_name = text.strip_edges()

	if player_name == "":
		print("이름을 입력하세요.")
		return
	
	print("Global 상태:", Global)
	Global.player_name = player_name  # ← 여기서 에러났다면 Global가 nil일 때임
	
	get_tree().change_scene_to_file("res://tscnfile/story.tscn")
