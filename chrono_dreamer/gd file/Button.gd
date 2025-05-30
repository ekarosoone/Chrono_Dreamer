extends Area2D


signal image_changed_to_crank_down

@onready var sprite = $"Crank-up"
@onready var timer_label = $"../Ui_Node/Label2"
var original_texture
var countdown_time := 10.0
var countdown_active := false  # 타이머 작동 여부 체크

func _ready():
	original_texture = sprite.texture
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player" and !countdown_active:
		sprite.texture = preload("res://Assest/Props/crank-down.png")
		emit_signal("image_changed_to_crank_down", self)
		countdown_time = 10.0
		countdown_active = true

func _physics_process(delta):
	if !countdown_active:
		return

	if Input.is_physical_key_pressed(KEY_S):
		print("⏸️ 시간 정지 중")
		return

	var time_scale := 1.0
	if Input.is_physical_key_pressed(KEY_A):
		time_scale = 0.3

	countdown_time -= delta * time_scale

	# 💬 텍스트로 표시
	timer_label.text = "⏱ %.1f초" % countdown_time
	print("남은 시간: %.1f초" % countdown_time)

	if countdown_time <= 0:
		countdown_active = false
		sprite.texture = original_texture
		timer_label.text = ""  # 시간 다 되면 텍스트 지우기
		print("✅ 이미지 복구 완료")
