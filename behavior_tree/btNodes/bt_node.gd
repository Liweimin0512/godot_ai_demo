extends Node
class_name BTNode

enum BTState {
	SUCCESS,
	FAIL,
	RUNNING,
	CANCELED
}

@export var active : bool = true
@export var debug : bool = true
var agent : Node

signal completed
var _state : BTState = BTState.CANCELED

func succeed() -> bool:
	_state = BTState.SUCCESS
	if debug:
		print_debug(name, "节点执行成功")
	return true


func fail() -> bool:
	if debug:
		print_debug(name, "节点执行失败")
	_state = BTState.FAIL
	return false


func run(agent : Node) -> void:
	self.agent = agent
	if debug:
		print_debug("正在执行节点： ", name)
	_state = BTState.RUNNING


func cancel() -> void:
	_state = BTState.CANCELED

func is_successed() -> bool:
	return _state == BTState.SUCCESS
