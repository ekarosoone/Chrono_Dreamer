extends Control

signal dialog_finished

var dialog_data = [
	{"name": "마리아", "text": "SPACE를 눌러 다음."},
	{"name": "주인공", "text": "안녕... 괜찮아?"},
	{"name": "마리아", "text": "너 누구야...?"},  
	{"name": "주인공", "text": "나는... 널 도우러 왔어."},
	{"name": "마리아", "text": "…도와준다고? 하하… 웃기지도 않네."},
	{"name": "주인공", "text": "여기서 얼마나 오래 있었는진 몰라도, 혼자 버티는 건... 힘들었을 거야."},
	{"name": "마리아", "text": "...여긴 나만의 장소야. 아무도 들어오면 안 돼."},
	{"name": "주인공", "text": "그렇지만... 넌 지금, 여기에 갇혀 있어."},
	{"name": "마리아", "text": "…정말, 나를... 꺼낼 수 있을까?"},
	{"name": "주인공", "text": "나 혼자서는 못해. 하지만 너와 함께라면 가능해."},
	{"name": "마리아", "text": "...무섭지만... 이상하게, 네 말이 믿어져."},
	{"name": "주인공", "text": "천천히, 한 걸음씩. 괜찮아."},
	{"name": "마리아", "text": "잊고 있던 감각이야... 누군가가 곁에 있다는 느낌."},
	{"name": "주인공", "text": "지금은 혼자가 아니야."},
	{"name": "마리아", "text": "...그래... 그럼, 가보자. 나도... 나아가고 싶어."},
	{"name": "주인공", "text": "좋아. 내가 앞장설게. 따라와."},
	{"name": "마리아", "text": "응... 고마워, {player_name}."}
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
		print("📢 emit_signal: dialog_finished")  # ✅ 시그널 발송 확인용
		emit_signal("dialog_finished")  # 시그널 발생
		Global.is_dialog_active = false
		queue_free()
