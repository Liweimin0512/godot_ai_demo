extends BTSequence
class_name BTRandomSequence


func _ready():
	randomize()
	children.shuffle()
