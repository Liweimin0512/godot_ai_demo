extends Node2D


func get_object_type() -> String:
	return "wood"


func action(character):
	character.pickup(self)
