extends BTDecorator
class_name BTRepeat

# 执行子节点若干次，并返回最后状态和勾选结果
@export_range(0, 999) var times_to_repeat : int = 1
@export var frequency : float

var result_count : int = times_to_repeat


func _on_child_completed(result : bool) -> void:
	if result_count <= 0 :
		result_count = times_to_repeat
		completed.emit(result)
	else :
		result_count -= 1
		await get_tree().create_timer(frequency).timeout
		child.run(agent)
