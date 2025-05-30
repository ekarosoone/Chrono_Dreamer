extends Control

var dialog_data = [
	{"name": "주인공", "text": "이 길... 기억나."},
	{"name": "마리아", "text": "처음 만났을 때 여기였지. 내가 널 낯설게 밀어냈던 곳."},
	{"name": "주인공", "text": "그땐 네가 무서워 보였어. 하지만 지금은..."},
	{"name": "마리아", "text": "지금은 나도 나 자신이 조금은 덜 무서워."},
	{"name": "주인공", "text": "같은 길인데, 느낌이 완전히 달라."},
	{"name": "마리아", "text": "우리가 바뀌었으니까. 그게 가장 큰 차이야."},
	{"name": "주인공", "text": "여긴 우리의 첫 만남이었지... 이제 와서 보면, 시작과 끝이 같은 장소라는 게 이상해."},
	{"name": "마리아", "text": "끝이 아니라, 다음을 향한 문이 될 수도 있잖아?"},
	{"name": "주인공", "text": "...그래. 중요한 건, 우리가 여기까지 '함께' 왔다는 거니까."},
	{"name": "마리아", "text": "응. 이제 괜찮아. 정말로."},
	{"name": "주인공", "text": "그럼, 가자. 우리 집으로."},
	{"name": "마리아", "text": "그래, {player_name}. 우리의 시간이 다시 시작되는 곳으로."}
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
