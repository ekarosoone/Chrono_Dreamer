extends Control

var story_lines = [
	"시간은 누구에게나 공평하게 흐르지.",
	"과거는 돌아오지 않고, 미래는 누구도 알 수 없어.",
	"하지만 너는... 예외야.",
	"너는 그녀의 꿈에 들어가, 시간을 멈추고, 느리게 할 수 있어.",
	"이제, 너의 행동이 그녀를 구할 수 있어.",
	"Chrono Dreamer — 시간의 경계를 넘어, 그녀를 구하라."
]


var current_line = 0

@onready var story_label = $StoryLabel

func _ready():
	story_label.text = ""
	show_next_line()

func _input(event):
	if event.is_action_pressed("ui_accept"):  # 보통 Enter 키
		show_next_line()

func show_next_line():
	if current_line < story_lines.size():
		story_label.text = story_lines[current_line]
		current_line += 1
	else:
		get_tree().change_scene_to_file("res://tscnfile/Tutorial.tscn")
