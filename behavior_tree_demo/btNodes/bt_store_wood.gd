extends BTLeaf
class_name BTStoreWood

func run(agent : Node) -> void:
	super(agent)
	if debug:
		print_debug("开始执行上交木材动作")
	if agent.can_store_wood():
		var ok : bool = await agent.store_wood()
		if ok :
			return await completed.emit(succeed())
		else:
			return await completed.emit(fail())
	else:
		return await completed.emit(fail())
