extends CharacterBody2D

@export var oscillation_speed := 1.0
@export var oscillation_amplitude := 200.0

var time_passed := 0.0
var base_y := 0.0
var is_paused := false

func _ready():
	base_y = position.y

func _physics_process(delta):
	if Input.is_physical_key_pressed(KEY_S):
		if !is_paused:
			is_paused = true
		move_and_collide(Vector2.ZERO)
		return
	else:
		if is_paused:
			# 진동이 끊기지 않도록 현재 위치에 맞는 time_passed 재조정
			var offset = position.y - base_y
			time_passed = asin(clamp(offset / oscillation_amplitude, -1.0, 1.0)) / oscillation_speed
			is_paused = false

	time_passed += delta
	var offset = sin(time_passed * oscillation_speed) * oscillation_amplitude
	var target_y = base_y + offset
	var motion = Vector2(0, target_y - position.y)
	move_and_collide(motion)
