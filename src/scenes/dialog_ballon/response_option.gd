class_name ResponseOption
extends Button

var response: DialogueResponse

func _ready() -> void:
	if not response: return
	self.text = "%d. %s" % [self.get_index() + 1, self.response.text]
