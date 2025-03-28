extends BTLeaf
class_name BTPickupWood


func run(agent : Node) -> void:
	super(agent)
	if debug:
		print_debug("开始执行拾取木材动作")

	if agent.can_pickup_wood():
		var ok : bool = await agent.pickup_wood()
		if ok :
			print_debug("拾取木材成功")
			return completed.emit(succeed())
		else:
			print_debug("拾取木材失败")
			return completed.emit(fail())
	else:
		print_debug("不存在木材，无法拾取")
		return completed.emit(fail())
