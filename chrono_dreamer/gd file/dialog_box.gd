extends Control

var dialog_data = [
	{"name": "주인공", "text": "여기가... 마리아의 꿈속...?"},
	{"name": "주인공", "text": "분명 들었어. 그녀가 고통 속에 갇혀 있다고."},
	{"name": "마리아", "text": "…누구죠? 당신은… 어떻게 여기에…?"},
	{"name": "주인공", "text": "난 널 도우러 왔어. 너를 이 꿈에서, 이 상처에서 꺼내기 위해."},
	{"name": "마리아", "text": "나를… 도우러 왔다고요?"},
	{"name": "마리아", "text": "대체 왜…? 우린 서로 알지도 못하는데…"},
	{"name": "주인공", "text": "네 목소리가 들렸어. 계속 반복되는 시간 속에서… 도움을 요청하고 있었어."},
	{"name": "마리아", "text": "...그게... 내 무의식이었을지도 몰라."},
	{"name": "마리아", "text": "이곳은 내 꿈이자, 내 기억이야. 잊고 싶었던 것들이, 그대로 남아 있는 곳."},
	{"name": "주인공", "text": "그래서 내가 왔어. 이 시간 속에서, 너와 함께 걸으려고."},
	{"name": "마리아", "text": "……고마워요. 하지만 조심해요."},
	{"name": "마리아", "text": "여기선 시간조차 쉽게 흘러가지 않아요. 멈추고, 느려져요."},
	{"name": "마리아", "text": "그 힘을 다룰 수 있다면, 이곳을 헤쳐 나갈 수 있을 거예요."},
	{"name": "주인공", "text": "시간을... 조작할 수 있다고?"},
	{"name": "마리아", "text": "이 세계의 규칙은 달라요. 당신의 의지가 흐름을 바꿀 수 있어요."},
	{"name": "마리아", "text": "준비됐으면… 첫걸음을 시작해봐요."}
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
