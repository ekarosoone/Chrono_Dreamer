extends Control

@onready var label = $VBoxContainer/EndingLabel
@onready var prompt = $VBoxContainer/PromptLabel

var ending_lines := [
	"…다녀왔어.",
	"그녀는... 이제 괜찮을까?",
	"아니, 그건... 그녀가 선택할 일이겠지.",
	"나는 그냥... 아주 잠깐, 시간을 멈췄을 뿐이야.",
	"",
	"Chrono Dreamer",
	"시간의 경계를 넘어, 그녀를 구한 이야기."
]

var current_line := 0
var showing_complete := false

func _ready():
	MusicManager.play_music("Last")
	label.text = ""
	prompt.visible = false
	#image.visible = true  # 마리아 이미지 보여줌
	show_next_line()

func show_next_line():
	if current_line < ending_lines.size():
		label.text += ending_lines[current_line] + "\n"
		current_line += 1
		await get_tree().create_timer(1.2).timeout
		show_next_line()
	else:
		showing_complete = true
		await get_tree().create_timer(2.0).timeout
		prompt.visible = true  # "Press any key to exit" 같은 메시지

func _input(event):
	if showing_complete and event is InputEventKey and event.pressed:
		get_tree().quit()  # 게임 종료 (또는 타이틀로 이동 가능)
