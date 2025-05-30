# MusicManager.gd
extends Node

@onready var player := AudioStreamPlayer.new()
var current_track := ""
var music_library := {
	"Stage1": preload("res://Assest/Sound/Stage1.mp3"),
	"Last": preload("res://Assest/Sound/Last.mp3"),
	"Ending": preload("res://Assest/Sound/Ending.mp3"),
	"Start": preload("res://Assest/Sound/Start.mp3"),
	"Cave": preload("res://Assest/Sound/Cave Sound.mp3"),
	"Dungeon": preload("res://Assest/Sound/Dungeon.mp3"),
	"Tutorial": preload("res://Assest/Sound/Peaceful2.mp3")
}

var fade_time := 1.5  # 초단위
var volume_tween = null  # ✅ GDScript에서 가장 안전한 선언 방법


func _ready():
	add_child(player)
	player.bus = "Music"  # 오디오 버스 설정 (필요 시)
	player.volume_db = -80  # 초기 음소거 상태
	volume_tween = null 

func play_music(track_name: String):
	if current_track == track_name:
		return  # 이미 같은 곡이면 생략

	if volume_tween:
		volume_tween.kill()  # 기존 tween 제거

	# 페이드아웃 현재 곡
	volume_tween = create_tween()
	volume_tween.tween_property(player, "volume_db", -80, fade_time)
	await volume_tween.finished

	# 새 곡 재생 및 페이드인
	current_track = track_name
	player.stop()
	player.stream = music_library[track_name]
	player.play()

	volume_tween = create_tween()
	volume_tween.tween_property(player, "volume_db", 0, fade_time)

func stop_music():
	if volume_tween:
		volume_tween.kill()

	volume_tween = create_tween()
	volume_tween.tween_property(player, "volume_db", -80, fade_time)
	await volume_tween.finished
	player.stop()
	current_track = ""
