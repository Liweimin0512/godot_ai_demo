extends BTNode
class_name BTLeaf

func _ready():
	assert(get_child_count() == 0, "执行节点不能有子节点！")
