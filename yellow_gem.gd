extends Area2D

onready var effect = get_node("effect")
onready var sprite = get_node("YellowSprite")
var owners

# create a custom signal. Use in place of using get_node(..) where possible
signal gem_grabbed

func _ready():
	# scale is property in the editor to change. Numerical properties only.
	effect.interpolate_property(sprite, 'scale', sprite.get_scale(),
			Vector2(2.0, 2.0), 0.3, Tween.TRANS_QUAD, Tween.EASE_OUT)
	effect.interpolate_property(sprite, 'modulate', Color(1, 1, 1, 1), Color(0.2, 1, 1, 0), 0.3,
			Tween.TRANS_QUAD, Tween.EASE_OUT)

func _on_YellowGem_area_entered(area):
	owners = get_shape_owners()
	if area.get_name() == 'Player':
		emit_signal('gem_grabbed')
		shape_owner_clear_shapes(owners[0])
		effect.start()

func _on_effect_tween_completed(object, key):
	queue_free()