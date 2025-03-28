extends Node
class_name StateBase

var state_name : String = "StateBase"

func enter(msg : Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func update(delta) -> void:
	pass

func physics_update(delta) -> void:
	pass
