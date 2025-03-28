extends Node

@export var auto_start : bool = true
@export var initial_state : NodePath
var current_state : StateBase

@onready var states = get_children()

func _ready():
	if auto_start:
		launch()

func _physics_process(delta):
	if current_state.has_method("physics_update"):
		current_state.physics_update(delta)	


func _process(delta):
	if current_state.has_method("update"):
		current_state.update(delta)


# 启动状态机
func launch() -> void:
	assert(initial_state != null, "初始状态不能为空")
	current_state = get_node(initial_state)
	current_state.enter()
	
# 添加状态


# 删除状态


# 是否存在状态
func has_state(state_name : String) -> bool:
	for s in states:
		if "state_name" in s and s.state_name == state_name:
			return true
	return false

# 获取状态
func get_state(state_name : String):
	for s in states:
		if "state_name" in s and s.state_name == state_name:
			return s
	return null

# 切换状态
func transition_to(state_name : String, msg : Dictionary = {}) -> void:
	if has_state(state_name):
		var state = get_state(state_name)
		if state:
			if current_state.has_method("exit"):
				current_state.exit()
			current_state = state
			if current_state.has_method("enter"):
				current_state.enter(msg)
