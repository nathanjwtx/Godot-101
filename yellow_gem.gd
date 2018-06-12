extends Area2D

# create a custom signal. Use in place of using get_node(..) where possible
signal gem_grabbed

func _ready():
	pass

func _on_YellowGem_area_entered(area):
	if area.get_name() == 'Player':
		emit_signal('gem_grabbed')
		queue_free()

