extends BTNode
class_name BTComposite

var current_child_node : int = 0
@onready var children := get_children()

func _ready():
	assert(get_child_count() > 1, "复合节点必须有多个子节点！")
	for c in get_children():
		c.completed.connect(_on_child_completed)

func _on_child_completed(result : bool) -> void:
	pass

func run_current_child_node() -> bool:
	if current_child_node >= get_children().size():
		current_child_node = 0
		return false
	else: 
		var current_node = get_child(current_child_node)
		current_node.completed.connect(_on_child_completed)
		current_child_node += 1
		current_node.run(agent)
		return true
