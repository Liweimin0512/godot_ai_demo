extends BTDecorator
class_name BTRepeatUntil

# 执行子节点， 直到返回指定的状态，然后将状态设置为子状态
@export_enum("Failure", "Success") var until_what : int
@export var frequency : float

@onready var expected_result : bool = bool(until_what)

func _on_child_completed(result : bool) -> void:
	if result == expected_result: 
		completed.emit(result)
	else :
		await get_tree().create_timer(frequency).timeout
		child.run(agent)
