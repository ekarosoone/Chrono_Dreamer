extends Node2D  # 또는 Sprite2D, CharacterBody2D 등

func _ready():
	print("🔍 BackGirl _ready 호출됨")

	var dialog = get_node("/root/Node2D/CanvasLayer/DialogBox")
	if dialog:
		print("✅ DialogBox 찾음")
		dialog.connect("dialog_finished", Callable(self, "_on_dialog_finished"))
	else:
		print("❌ DialogBox 못 찾음 (절대 경로)")



func _on_dialog_finished():
	print("🎉 시그널 받음! 대화 종료 감지됨")
	self.visible = false
