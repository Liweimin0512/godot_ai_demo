extends BTLeaf
class_name BTPickupAxe


func run(agent : Node) -> void:
	super(agent)
	if debug:
		print_debug("开始执行拾取斧子动作")

	if agent.can_pickup_axe():
		var ok : bool = await agent.pickup_axe()
		if ok :
			print_debug("拾取斧子成功")
			return completed.emit(succeed())
		else:
			print_debug("拾取斧子失败")
			return completed.emit(fail())
	else:
		print_debug("不存在斧子，无法拾取")
		return completed.emit(fail())
