extends StateBase

@export var wait_time : float = 2

func _ready():
	state_name = "state_1_chifan"

func enter(msg : Dictionary = {}) -> void:
	print_debug("《《《《enter state 1 吃饭！")
	await get_tree().create_timer(wait_time, false).timeout
	owner.transition_to("state_2_shuijiao", {"wait_time" : wait_time})

func exit() -> void:
	print_debug("》》》》退出状态： 1 吃饭！")
#
#func _process(delta):
#	pass

func update(delta):
	pass
