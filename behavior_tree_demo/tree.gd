extends StaticBody2D

@export var can_cut : bool = false


func _ready():
	self.set_grown()


func get_object_type():
	if can_cut:
		return "tree"
	else:
		return "tree_not_ready"


func set_grown():
	$AnimationPlayer.play("Grown")


func action(character):
	printerr(position.distance_to(character.position))	
	if !can_cut:
		print("This tree cannot be cut")
	elif position.distance_to(character.position) > 30:
		print("This tree is too far")
	elif character.held != null and character.held.get_object_type() == "axe":
		$AnimationPlayer.play("Cut")
		return true
	else:
		print("you need an axe to cut a tree")
	return false


func drop_items():
	for c in [ preload("res://behavior_tree_demo/wood.tscn"), preload("res://behavior_tree_demo/fruit.tscn") ]:
		for i in range(randi() % 6):
			var object = c.instantiate()
			var direction = Vector2(randf_range(-16.0, 16.0), randf_range(-16.0, 16.0))
			object.position = position + direction
			get_parent().add_child(object)
