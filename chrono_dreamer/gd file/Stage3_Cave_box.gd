extends Control

var dialog_data = [
	{"name": "마리아", "text": "이 길... 처음엔 참 무서웠는데."},
	{"name": "주인공", "text": "지금은 어때?"},
	{"name": "마리아", "text": "조금은 익숙해진 것 같아. 어둠 속에서도 말이야."},
	{"name": "주인공", "text": "사실 나도 좀 무서웠어. 널 만났을 땐, 내가 뭘 할 수 있을지 몰랐거든."},
	{"name": "마리아", "text": "그런데도, 계속 곁에 있어줬잖아."},
	{"name": "주인공", "text": "너도 나랑 같이 있었잖아. 우린... 함께였으니까."},
	{"name": "마리아", "text": "내가 나 자신을 다시 믿을 수 있을 줄은 몰랐어."},
	{"name": "주인공", "text": "이 동굴을 빠져나가면, 그게 진짜 시작이겠지."},
	{"name": "마리아", "text": "응. 도망치던 꿈에서… 드디어 깨어나는 거니까."},
	{"name": "주인공", "text": "가자. 우리 집으로 돌아가자."},
	{"name": "마리아", "text": "…응. 같이 가줘서 고마워, {player_name}."}

]



var current_line = 0

@onready var name_label = $Panel/NameLabel
@onready var dialog_label = $Panel/DialogLabel
@onready var portrait = $Panel/Portrait

func _ready():
	show_next_line()
	Global.is_dialog_active = true
	show_next_line()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		show_next_line()

func show_next_line():
	if current_line < dialog_data.size():
		var line = dialog_data[current_line]
		var display_name = line.name

		# 1) 이름 표시
		if display_name == "주인공":
			name_label.text = Global.player_name
		else:
			name_label.text = display_name

		# 2) 대사 텍스트 치환
		var text = line.text.replace("{player_name}", Global.player_name)
		dialog_label.text = text

		# 3) 일러스트 로딩
		var image_path: String
		if display_name == "주인공":
			image_path = "res://Assest/Cha/Juingong.png"
		else:
			image_path = "res://Assest/Cha/%s.png" % display_name

		if ResourceLoader.exists(image_path):
			portrait.texture = load(image_path)
		else:
			portrait.texture = null
			print("⚠️ Portrait not found:", image_path)

		# 4) 캐릭터별 위치 조정
		match display_name:
			"마리아":
				portrait.anchor_left = 0.5
				portrait.anchor_top = 1.0
				portrait.anchor_right = 0.5
				portrait.anchor_bottom = 1.0
				portrait.offset_left = -1000
				portrait.offset_top = -500
				portrait.size = Vector2(500, 500)

			"주인공":
				portrait.anchor_left = 0.5
				portrait.anchor_top = 1.0
				portrait.anchor_right = 0.5
				portrait.anchor_bottom = 1.0
				portrait.offset_left = -1000
				portrait.offset_top = -450
				portrait.size = Vector2(500, 500)

		current_line += 1
	else:
		Global.is_dialog_active = false
		queue_free()
