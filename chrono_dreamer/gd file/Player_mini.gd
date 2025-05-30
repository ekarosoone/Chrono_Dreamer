extends CharacterBody2D

const WALK_SPEED := 100
const RUN_SPEED := 200
const JUMP_VELOCITY := -300
const BASE_GRAVITY := 1200  # 중력 기본값

@onready var sprite = $AnimatedSprite2D
var flipped := false
var is_jumping := false
var current_gravity := BASE_GRAVITY

func _ready():
	$Camera2D.make_current()
	print("Camera current:", $Camera2D.is_current())

func _physics_process(delta):
	if Global.is_dialog_active:
		return  # 대화 중이면 아예 움직임 스킵
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	# 애니메이션 재생 속도 조절 (슬로우 모션)
	sprite.speed_scale = 0.3 if Input.is_physical_key_pressed(KEY_A) else 1.0

	# Shift 키 눌렀는지 체크
	var is_running = Input.is_physical_key_pressed(KEY_SHIFT)

	# A 키 눌렀을 때 슬로우 모션 중력 적용
	if Input.is_physical_key_pressed(KEY_A):
		current_gravity = BASE_GRAVITY * 0.3
	else:
		current_gravity = BASE_GRAVITY

	# 달리기 or 걷기 속도 결정
	var move_speed = RUN_SPEED if is_running else WALK_SPEED
	velocity.x = direction * move_speed

	# 점프
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		sprite.play("Jump")

	# 중력 적용
	if !is_on_floor():
		velocity.y += current_gravity * delta

	move_and_slide()

	# ←→ 반전 + 튐 보정
	if direction != 0:
		var should_flip = direction < 0
		if flipped != should_flip:
			flipped = should_flip
			sprite.flip_h = flipped
			sprite.offset.x = -abs(sprite.offset.x) if flipped else abs(sprite.offset.x)

	# 애니메이션 처리
	if is_on_floor():
		if is_jumping:
			is_jumping = false
		if direction != 0:
			var target_anim = "Run" if is_running else "Walk"
			if !sprite.is_playing() or sprite.animation != target_anim:
				sprite.play(target_anim)
		else:
			if !sprite.is_playing() or sprite.animation != "Idle":
				sprite.play("Idle")

	# 밀 수 있는 오브젝트 감지 및 밀기
		if direction != 0:
			var space_state = get_world_2d().direct_space_state
			var ray = PhysicsRayQueryParameters2D.create(
				global_position,
				global_position + Vector2(direction * 10, 0)
			)
			ray.exclude = [self]  # 자기 자신 제외

			var result = space_state.intersect_ray(ray)

			if result and result.collider and result.collider.is_in_group("pushable"):
				result.collider.apply_central_impulse(Vector2(300 * direction, 0))
