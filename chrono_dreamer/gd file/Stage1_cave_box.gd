extends Control

var dialog_data = [
	{"name": "마리아", "text": "SPACE를 눌러 다음."},
	{"name": "주인공", "text": "……여긴 어디지? 갑자기 분위기가 확 달라졌어."},
	{"name": "마리아", "text": "잘 왔어. 이곳은 '내면의 동굴'이라고 불리는 곳이야."},
	{"name": "주인공", "text": "내면...? 바깥보다 훨씬 조용하고... 이상하게 익숙한 느낌이 들어."},
	{"name": "마리아", "text": "시간은 빛 속에서 흔들리지만, 어둠 속에서는 그 본질이 드러나거든."},
	{"name": "마리아", "text": "여기서는 네가 가진 '시간의 힘'이 더욱 명확해질 거야."},
	{"name": "주인공", "text": "힘이 명확해진다고...? 어떻게 되는 건데?"},
	{"name": "마리아", "text": "이제부터는 단순히 시간을 늦추는 것만으론 충분하지 않아."},
	{"name": "마리아", "text": "움직임, 패턴, 반응. 모든 것이 시간과 연결돼 있어. 그걸 감각으로 익혀야 해."},
	{"name": "주인공", "text": "……왠지 숨이 막힐 것 같아. 하지만... 가야겠지."},
	{"name": "마리아", "text": "맞아. 두려움은 자연스러운 감정이야. 중요한 건, 그 안에서 길을 찾는 거지."},
	{"name": "마리아", "text": "그리고 기억해. 이 동굴 안에서는 어떤 선택도, 쉽게 되돌릴 수 없어."},
	{"name": "주인공", "text": "……긴장되지만, 해볼게. 내 시간은, 내가 선택할게."}
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
