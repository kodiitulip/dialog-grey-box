class_name DialogueSegment
extends PanelContainer

@export var dialogue_label_template: DialogueLabel

var dialogue_label: DialogueLabel

@onready var character_label: RichTextLabel = %CharacterLabel as RichTextLabel
@onready var dialogue_lines: VBoxContainer = %DialogueLines as VBoxContainer


func _ready() -> void:
	if dialogue_label_template and dialogue_label_template.get_parent():
		dialogue_label_template.get_parent().remove_child(dialogue_label_template)


static func fix_ownership(parent: Node, new_owner: Node) -> void:
	for child in parent.get_children():
		if child.owner != new_owner:
			child.owner = new_owner
		if child.get_child_count() > 0:
			fix_ownership(child, new_owner)


func create_new_dialogue_line() -> void:
	var label: DialogueLabel
	if is_instance_valid(dialogue_label_template):
		label = dialogue_label_template.duplicate(DUPLICATE_GROUPS | DUPLICATE_SCRIPTS | DUPLICATE_SIGNALS)
	else:
		label = DialogueLabel.new()
		label.fit_content = true
	#label.owner = self
	dialogue_lines.add_child(label)
	dialogue_label = label
