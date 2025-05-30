extends RigidBody2D

@export var normal_gravity := 1.0
@export var slow_gravity := 0.3
@export var slow_factor := 0.3  # 느려지는 속도 배율
@export var oscillation_speed := 3.0   # 움직임 속도
@export var oscillation_amplitude := 400.0  # 위아래로 이동하는 범위

var time_passed := 0.0
func _ready():
	lock_rotation = true

func _physics_process(delta):
	if Input.is_physical_key_pressed(KEY_S):
		sleeping = true
		return
	else:
		sleeping = false

	if Input.is_physical_key_pressed(KEY_A):
		gravity_scale = slow_gravity
		linear_velocity *= slow_factor
	else:
		gravity_scale = normal_gravity

	# 진동 움직임 적용
	time_passed += delta
	var vertical_velocity = sin(time_passed * oscillation_speed) * oscillation_amplitude
	linear_velocity.y = vertical_velocity
