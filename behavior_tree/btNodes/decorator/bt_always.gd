extends BTDecorator
class_name BTAlways

@export_enum("Fail", "Succeed") var always_what : int = 0
@onready var return_func : String = "fail" if always_what == 0 else "succeed"
# 总是成功或失败，无视子节点返回的结果

func _on_child_completed(result : bool) -> void:
	completed.emit(call(return_func))
