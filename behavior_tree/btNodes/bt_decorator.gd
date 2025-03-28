extends BTNode
class_name BTDecorator

@onready var child : BTNode = get_child(0)


func _ready():
	assert(get_child_count() == 1, "装饰节点有且只有 1 个子节点！")
	child.completed.connect(_on_child_completed)


func run(agent : Node) -> void:
	child.run(agent)


func _on_child_completed(result : bool) -> void:
	pass
