extends Node


func get_object_type() -> String:
	return "axe"


func action(character):
	character.pickup(self)
