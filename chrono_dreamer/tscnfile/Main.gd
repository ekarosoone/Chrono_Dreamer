extends Node2D

func _ready():
	var crank = $Button  # 🔍 정확한 이름
	var gate = $Face_door  # 🔍 정확한 이름

	if crank and gate:
		var result = crank.connect("image_changed_to_crank_down", Callable(gate, "try_open"))
		if result != OK:
			print("❌ 시그널 연결 실패! 에러 코드:", result)
		else:
			print("✅ 시그널 연결 성공!")
	else:
		print("🚨 crank 또는 gate가 null입니다.")
