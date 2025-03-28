extends CharacterBody2D
class_name PlayerCharacter


@export var run_speed : float = 10.0
var held = null
var life = 100.0

var motion := Vector2(0, 0)
var target = null
var face : bool = true

signal run_end
signal action_end

@onready var sprite : Sprite2D = $Sprite2d


func _physics_process(delta):
	_run(delta)
	life -= delta
	sprite.flip_h = face
	if life <= 0:
		set_physics_process(false)
#		anim("Die")
		return


func _run(delta):
	if target == null:
#		print_debug("移动目标为空！")
		return
	
	face = true if self.position.x > target.x else false
	var target_position := Vector2( ((target.x + 20) if self.position.x > target.x else (target.x - 20) ) \
		, target.y)
	$NavigationAgent2d.set_target_location(target_position)
	var next_location : Vector2 = $NavigationAgent2d.get_next_location()
#	print_debug("目标位置：" , target_position, "当前所在位置： ", position , "下一个移动位置： " ,  \
#		next_location, "距离目标点距离：" ,position.distance_to(target_position))
	if self.position.distance_to(target_position) > 1:
		self.velocity = position.direction_to(next_location) * run_speed
		self.anim("Run")
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		target = null
		self.anim("Idle")
		run_end.emit(true)


func run_to(p):
	target = p


func holds(object_type):
	if held != null and held.get_object_type() == object_type:
		return true
	return false


func pickup_object(object_type) -> bool:
	var nearest = find_nearest_object(object_type)
	if nearest.object == null or nearest.distance > 100.0:
		return false
	pickup(nearest.object)
	return true


func pickup(object):
	if held != null:
		get_parent().add_child(held)
		held.position = self.position
#		held.apply_impulse(Vector3(0.0, 0.0, 0.0), Vector3(0.0, 1.0, 1.0).rotated(Vector3(0.0, 1.0, 0.0), rotation.y))
		held.show()
	object.get_parent().remove_child(object)
	held = object


func store_held(object_type) -> bool:
	if held != null and held.get_object_type() == object_type:
		held = null
		return true
	else:
		return false


func pickup_nearest_object(object_type) -> bool:
	if holds(object_type):
		printerr("当前正持有： ", object_type," 无法再次拾取")
		return false
	var object = find_nearest_object(object_type).object
	if object == null:
		printerr("无法拾取： ", object_type," 目标对象 为null")
		return false
	run_to(object.position)
	var ok :bool = await self.run_end
	if !ok:
		printerr("无法拾取： ", object_type," 无法移动到目标位置")
		return false
	return pickup_object(object_type)


func find_nearest_object(object_type = null) -> Dictionary:
	var nearest_distance = 1000
	var nearest_object = null
	for o in get_parent().get_children():
		if o.is_inside_tree() and o.has_method("get_object_type"):
			var distance = (self.position - o.position).length()
			if o != self and o.get_script() != null and (object_type == null \
				or o.get_object_type() == object_type) and distance < nearest_distance:
				nearest_distance = distance
				nearest_object = o
	return { object=nearest_object, distance=nearest_distance }


func can_find_object(object_type = null) -> bool:
#	var world : World = get_parent()
#	if not world:
#		return false
	for o in get_parent().get_children():
		if o.is_inside_tree() and o.has_method("get_object_type"):
			if o != self and o.get_script() != null and (object_type == null \
				or o.get_object_type() == object_type):
					return true
	return false


func use_nearest_object(object_type):
	var object = find_nearest_object(object_type).object
	if object == null:
		return false
	run_to(object.position)
	var ok : bool = await self.run_end
	if !ok:
		return false
	return object.action(self)


func anim(a):
	var anim = $"AnimationPlayer"
	if anim.current_animation != a:
		anim.play(a)


func pickup_axe():
	return await pickup_nearest_object("axe")
	
func pickup_fruit():
	return await pickup_nearest_object("fruit")
	
func pickup_wood():
	return await pickup_nearest_object("wood")


func cut_tree():
	anim("Axe")
	return await use_nearest_object("tree")


func store_wood() -> bool:
	return await use_nearest_object("box")

func eat_fruit():
	if held != null and held.get_object_type() == "fruit":
		held.free()
		held = null
		life += 20
		if life > 100: life = 100
		return true
	return false


func do_grow_tree():
	if held == null or held.get_object_type() != "fruit":
		return false
	held.free()
	held = null
	var tree = preload("res://behavior_tree_demo/tree.tscn").instantiate()
	tree.position = self.position # + 2.0 * Vector2(sin(rotation.y), 0.0, cos(rotation.y))
	get_parent().add_child(tree)
	return true


func grow_tree():
	# Check we have a fruit
	if held == null or held.get_object_type() != "fruit":
		return false
	# Find a nice location for the tree
	var box = get_node("../Box")
	var p = null
	for i in range(5, 100, 5):
		for j in range(10):
			var test_p := Vector2(randf_range(-i, i), randf_range(-i, i))
			var ok = true
			for c in get_parent().get_children():
				if (c == box or c.has_method("get_object_type") and c.get_object_type().left(4) == "tree") \
					and (c.position - test_p).length() < 5.0:
					ok = false
			if ok:
				p = test_p
				break
		if p != null:
			break
	# return false if no location was found
	if p == null:
		return false
	# Try to run to location and return false uon failure
	run_to(p + position)
	var ok :bool = await self.run_end
	if !ok:
		return false
	# Destroy fruit and create growing tree
	return do_grow_tree()


func can_store_wood() -> bool:
	return true if held != null and held.get_object_type() == "wood" else false

func can_pickup_wood() -> bool:
	return true if can_find_object("wood") else false

func can_pickup_axe() -> bool:
	return true if can_find_object("axe") else false

func can_pickup_fruit() -> bool:
	return true if can_find_object("fruit") else false

func can_cut_tree() -> bool:
	return true if can_find_object("tree") and held != null and held.get_object_type() == "axe" else false

func can_grow_tree() -> bool:
	return true if held != null and held.get_object_type() == "fruit" else false

func need_grow_tree() -> bool:
	var count : int = 0
	for c in get_parent().get_children():
		if c.has_method("get_object_type") and (c.get_object_type() == "tree" or \
			c.get_object_type() == "tree_not_ready"):
			count += 1
	if count >= 3 :
		return false
	return true
