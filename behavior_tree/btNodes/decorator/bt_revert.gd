extends BTDecorator
class_name BTRevert

# 相反节点，如果子节点成功则失败，反之则成功

func _on_child_completed(result : bool) -> void:
	if result == true:
		completed.emit(fail())
	else:
		completed.emit(succeed())
