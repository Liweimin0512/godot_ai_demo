extends Node2D


func get_object_type() -> String:
	return "fruit"


func action(character):
	character.pickup(self)
