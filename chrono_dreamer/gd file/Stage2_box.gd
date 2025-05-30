extends Control

var dialog_data = [
	{"name": "마리아", "text": "SPACE를 눌러 다음."},
	{"name": "주인공", "text": "조금 있으면 도착이야"},
	{"name": "주인공", "text": "여긴... 숨이 막힐 정도로 조용하네."},
	{"name": "마리아", "text": "…내가 감춰두었던 기억들이 모여 있는 곳이야."},
	{"name": "주인공", "text": "이 얼굴... 너를 보고 있는 것 같아."},
	{"name": "마리아", "text": "과거는 잊혀지지 않아. 그냥 눈을 감고 있을 뿐이지."},
	{"name": "주인공", "text": "그래도... 이젠 마주할 준비가 된 거잖아."},
	{"name": "마리아", "text": "응. 그게... 당신과 만난 이후로 달라졌어."}
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
