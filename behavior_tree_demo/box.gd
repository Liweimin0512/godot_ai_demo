extends RigidBody2D


var count := 0


func get_object_type() -> String:
	return "box"


func action(character) -> bool:
	if character.store_held("wood"):
		count += 1
		return true
	else:
		return false
