extends Node

onready var gem_container = get_node("gem_container")
onready var gem = preload("res://yellow_gem.tscn")
onready var score_label = get_node('HUD/Score')
onready var time_label = get_node('HUD/time_label')
onready var game_timer = get_node('game_time')
onready var game_over = get_node('HUD/game_over')
onready var effect = get_node("game_time/tween_effect")

var screensize
var score = 0
var level = 1

func _ready():
	randomize()
	screensize = get_viewport().size
	set_process(true)
	spawn_gems(10)
	game_over.set_text('GAME OVER')
	game_over.visible = false
	effect.interpolate_property(game_over, 'modulate', Color(0.2, 0.2, 0.2, 0), Color(0.2, 0.7, 1, 1),
			0.8, Tween.TRANS_BOUNCE, Tween.EASE_OUT)

func spawn_gems(num):
	for x in range(num):
		var g = gem.instance()
		gem_container.add_child(g)
		g.connect('gem_grabbed', self, '_on_gem_grabbed')
		g.set_position(Vector2(rand_range(0, screensize.x - 40), 
								rand_range(0, screensize.y - 40)))

func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))
	if gem_container.get_child_count() == 0:
		level += 1
		spawn_gems(level * 10)

func _on_gem_grabbed():
	score += 10
	score_label.set_text(str(score))

func _on_game_time_timeout():
	get_node('Player').set_process(false)
	effect.start()

func _on_tween_effect_tween_started(object, key):
	game_over.visible = true
