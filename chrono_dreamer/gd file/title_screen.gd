extends Control

@onready var start_button = $StartButton
@onready var quit_button = $QuitButton  # ← Button2가 실제 노드 이름

func _ready():
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	MusicManager.play_music("Start")

func _on_start_pressed():
	print("시작 버튼 눌림")
	get_tree().change_scene_to_file("res://tscnfile/TutorialIntro.tscn")  # 파일 경로 정확히 확인!

func _on_quit_pressed():
	print("종료 버튼 눌림")
	get_tree().quit()
