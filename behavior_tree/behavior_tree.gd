extends Node
class_name BehaviorTree

@export var active : bool = true
@onready var root_node : BTNode = get_child(0)
@export var _agent : NodePath
@onready var agent : Node = get_node(_agent)


func _ready():
	if not active:
		return
	root_node.completed.connect(_on_root_node_completed)
	root_node.run(agent)


func _on_root_node_completed( _result : bool) -> void:
	await get_tree().create_timer(0.2).timeout
	root_node.run(agent)
