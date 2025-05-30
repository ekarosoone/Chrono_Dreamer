extends Control

var dialog_data = [
	{"name": "마리아", "text": "SPACE를 눌러 다음."},
	{"name": "주인공", "text": "…여긴... 아까 그 길?"},
	{"name": "주인공", "text": "아니, 뭔가 달라. 같은 장소인데... 느낌이 완전히 다르잖아."},
	{"name": "마리아", "text": "여긴 내 기억이 변형된 공간이야. 가장 익숙하면서도, 가장 낯선 곳."},
	{"name": "주인공", "text": "빛은 붉고, 그림자는 길고... 무언가 안 좋은 일이 있었던 장소야?"},
	{"name": "마리아", "text": "...어릴 적, 여기에 혼자 남겨진 적이 있어."},
	{"name": "마리아", "text": "그날 이후로, 시간은 여길 피해 가는 듯했지."},
	{"name": "주인공", "text": "그럼 이제... 그 시간을 다시 마주해야겠네."},
	{"name": "마리아", "text": "응. 이번엔 혼자가 아니니까."}

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
