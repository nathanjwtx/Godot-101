extends Sprite

var velocity
var extents
var screenSize
var sprPosition
var initVelocity
var spin

func _ready():
	randomize() # resets the initial random number each time else it stays the same
	screenSize = get_viewport_rect().size
	extents = get_texture().get_size() / 2
	sprPosition = screenSize / 2
	# initVelocity = velocity.x
	velocity = Vector2(rand_range(100, 300), 0).rotated(rand_range(0, 2*PI))
	spin = rand_range(-PI, PI)
	set_process(true)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _process(delta):
	# setting the speed like this decouples it from framerate fps
	set_rotation(get_rotation() + spin * delta)
	sprPosition += velocity * delta
	if sprPosition.x >= screenSize.x - extents.x:
		# in case sprite sticks on edge of screen for some reason we set the starting return position
		sprPosition.x = screenSize.x - extents.x
		velocity.x *= -1
	elif sprPosition.x <= extents.x:
		sprPosition.x = extents.x
		velocity.x *= -1
	if sprPosition.y >= screenSize.y - extents.y:
		sprPosition.y = screenSize.y - extents.y
		velocity.y *= -1
	elif sprPosition.y <= extents.y:
		sprPosition.y = extents.y
		velocity.y *= -1

	# this looks cool but only really works with initial velocity of 100.
	# Possibly related to screen size :/
	# if sprPosition.x >= (screenSize.x - initVelocity):
	# 	velocity.x += -1
	# elif sprPosition.x <= initVelocity:
	# 	velocity.x += 1
	# if sprPosition.y >= screenSize.y - extents.y:
	# 	velocity.y += -1
	# elif sprPosition.y <= extents.y:
	# 	velocity.y += 1
	set_position(sprPosition)