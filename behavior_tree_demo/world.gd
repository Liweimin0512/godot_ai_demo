extends Node2D
class_name World

@onready var player : PlayerCharacter = $Player
@onready var icon_held : TextureRect = $form_main/icon_held
@onready var lefe_progress_bar : ProgressBar = $form_main/ProgressBar
@onready var label_wood_amount : Label = $form_main/Panel/HBoxContainer/wood_amount
@onready var game_objects : Array = get_children()


func _ready() -> void:
	seed(Time.get_unix_time_from_system())
	var tree_positions = PackedVector2Array()
	for i in range(5):
		var tree = preload("res://behavior_tree_demo/tree.tscn").instantiate()
		while true:
			var p = Vector2((randf_range(0.2,0.8)) * 576.0, (randf_range(0.2,0.8)) * 328.0)
			var ok = true
			for t in tree_positions:
				if (p-t).length() < 3:
					ok = false
					break
			if ok:
				tree.position = Vector2(p.x, p.y)
				tree_positions.append(p)
				break
		add_child(tree)
	var axe : Node = load("res://behavior_tree_demo/axe.tscn").instantiate()
	player.held = axe
#	player.run_to($box)


func _process(delta: float) -> void:
	lefe_progress_bar.value = player.life
	label_wood_amount.text = str($box.count)
	update_held_icon()


func update_held_icon():
	if player.held == null:
		icon_held.visible = false
	else:
		icon_held.visible = true
		icon_held.texture = load("res://assets/" + player.held.get_object_type()+".tres")
