class_name DialogueLineContainer
extends VBoxContainer

const DIALOGUE_SEGMENT = preload("uid://b2mmla5p7x4n7")

## Optionally specify a control to duplicate for each response
@export var response_template: DialogueSegment


func _ready() -> void:
	if is_instance_valid(response_template):
		response_template.get_parent().remove_child(response_template)


func _exit_tree() -> void:
	if is_instance_valid(response_template):
		response_template.queue_free()


# Set up the visual side of things.
func apply_dialogue() -> DialogueSegment:
	## Remove any current items
	#for item: Node in get_children():
		#if item == response_template: continue
		#remove_child(item)
		#item.queue_free()

	var item: DialogueSegment
	if is_instance_valid(response_template):
		item = response_template.duplicate(DUPLICATE_GROUPS | DUPLICATE_SCRIPTS | DUPLICATE_SIGNALS)
		DialogueSegment.fix_ownership(item, item)
		item.show()
	else:
		item = DIALOGUE_SEGMENT.instantiate()
	item.name = "DialogueSegment%d" % get_child_count()
	add_child(item)
	return item
