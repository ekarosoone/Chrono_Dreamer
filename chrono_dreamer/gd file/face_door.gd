extends StaticBody2D

@onready var sprite = $"Face-block"
@onready var crank_node = get_node("../Button")  # Button은 Crank-up의 부모
@onready var collider = $CollisionShape2D

var is_open = false
var original_position: Vector2

func _ready():
	original_position = global_position  # 원래 위치 저장
	print("📍 문 초기 위치:", original_position)

func _process(_delta):
	if crank_node == null:
		print("❌ crank_node가 null입니다.")
		return

	var crank_sprite = crank_node.get_node_or_null("Crank-up")
	if crank_sprite == null:
		print("❌ Crank-up 노드를 찾을 수 없음")
		return

	var path = crank_sprite.texture.resource_path
	#print("🔎 현재 크랭크 이미지 경로:", path)

	if path == "res://Assest/Props/crank-down.png" and !is_open:
		print("✅ 조건 만족 → 문 열기")
		open_gate()
	elif path != "res://Assest/Props/crank-down.png" and is_open:
		#print("🔄 이미지 복구됨 → 문 닫기")
		close_gate()
	#else:
		#print("⛔ 변화 없음 → 문 상태 유지")

func open_gate():
	is_open = true
	global_position += Vector2(128, 0)
	print("➡️ 문 이동 완료")

func close_gate():
	is_open = false
	global_position = original_position
	print("⬅️ 문 원래 위치로 복귀")
