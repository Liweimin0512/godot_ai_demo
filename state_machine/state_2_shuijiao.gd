extends StateBase

func _init():
	state_name = "state_2_shuijiao"

func enter(msg : Dictionary = {}) -> void:
	print_debug("《《《《enter state 2 睡觉！")
	print_debug("从吃饭状态切换， 暂停时间数据：" ,  msg["wait_time"])
