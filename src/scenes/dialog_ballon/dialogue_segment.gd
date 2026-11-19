class_name DialogueSegment
extends BoxContainer

@onready var character_label: RichTextLabel = %CharacterLabel as RichTextLabel
@onready var dialogue_label: DialogueLabel = %DialogueLabel as DialogueLabel


static func fix_ownership(parent: Node, new_owner: Node) -> void:
	for child in parent.get_children():
		if child.owner != new_owner:
			child.owner = new_owner
		if child.get_child_count() > 0:
			fix_ownership(child, new_owner)
