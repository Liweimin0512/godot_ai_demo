extends BTSelector
class_name BTRandomSelector


func _ready():
	randomize()
	children.shuffle()
