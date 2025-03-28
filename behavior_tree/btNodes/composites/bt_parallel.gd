extends BTComposite
class_name BTParallel

var result_count := 0

func run(agent : Node) -> void:
	var bt_child : BTNode
	for c in children:
		bt_child = c
		bt_child.run(agent)


func _on_child_completed(result : bool) -> void:
	if result_count >= children.size() :
		result_count = 0
		completed.emit(succeed())
	else:
		result_count += 1
