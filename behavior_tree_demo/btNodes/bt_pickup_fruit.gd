extends BTLeaf
class_name BTPickupFruit


func run(agent : Node) -> void:
	super(agent)
	if debug:
		print_debug("开始执行拾取果实动作")

	if agent.can_pickup_fruit():
		var ok : bool = await agent.pickup_fruit()
		if ok :
			print_debug("拾取果实成功")
			return completed.emit(succeed())
		else:
			print_debug("拾取果实失败")
			return completed.emit(fail())
	else:
		print_debug("不存在果实，无法拾取")
		return completed.emit(fail())
