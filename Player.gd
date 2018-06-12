extends Area2D

export var speed = 400

var vel = Vector2()
var extents
var screensize

func _ready():
	set_process(true)
	screensize = get_viewport_rect().size
	extents = get_node("Sprite").get_texture().get_size() / 2
	set_position(screensize / 2)

func _process(delta):
	var playerInput = Vector2()
	# int() converts a Boolean into a numeric value
	playerInput.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	playerInput.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	vel = playerInput.normalized() * speed
	var pos = get_position() + vel * delta
	pos.x = clamp(pos.x, extents.x / 2, screensize.x - (extents.x / 2))
	pos.y = clamp(pos.y, (extents.y / 2), screensize.y - (extents.y / 2))
	set_position(pos)