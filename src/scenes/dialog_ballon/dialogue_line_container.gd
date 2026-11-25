class_name DialogueLineContainer
extends VBoxContainer

const DIALOGUE_SEGMENT = preload("uid://b2mmla5p7x4n7")

var last_character: String

## Optionally specify a control to duplicate for each response
@export var segment_template: DialogueSegment


func _ready() -> void:
	if is_instance_valid(segment_template):
		segment_template.get_parent().remove_child(segment_template)


func _exit_tree() -> void:
	if is_instance_valid(segment_template):
		segment_template.queue_free()


func get_last_or_new_segment(character: String) -> DialogueSegment:
	var item: DialogueSegment
	if last_character == character and get_child_count() > 0:
		item = get_child(get_child_count() - 1) as DialogueSegment
	else:
		if is_instance_valid(segment_template):
			item = segment_template.duplicate(DUPLICATE_GROUPS | DUPLICATE_SCRIPTS | DUPLICATE_SIGNALS )
			DialogueSegment.fix_ownership(item, item)
			item.show()
		else:
			item = DIALOGUE_SEGMENT.instantiate()
		last_character = character
		item.name = "DialogueSegment%d" % get_child_count()
		add_child(item)
	item.create_new_dialogue_line()
	return item
