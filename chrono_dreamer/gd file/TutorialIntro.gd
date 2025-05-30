extends Control

@onready var label = $VBoxContainer/InstructionsLabel
@onready var prompt = $VBoxContainer/PromptLabel

var instructions := [
	"[↑] 방향키 — 점프",
	"[←][→] 방향키 — 좌우 이동",
	"[A] — 시간 느리게 흐르기",
	"[S] — 시간 멈추기",
	"",
	"* 시간은 네 의지에 따라 흐른다."
]

var current_line := 0
var showing_complete := false

func _ready():
	label.text = ""
	prompt.visible = false
	show_next_line()

func show_next_line():
	if current_line < instructions.size():
		label.text += instructions[current_line] + "\n"
		current_line += 1
		await get_tree().create_timer(0.8).timeout
		show_next_line()
	else:
		showing_complete = true
		await get_tree().create_timer(1.0).timeout
		prompt.visible = true  # "Press any key..." 표시

func _input(event):
	if showing_complete and event is InputEventKey and event.pressed:
		get_tree().change_scene_to_file("res://tscnfile/doipbu.tscn")  # 다음 씬으로 전환
