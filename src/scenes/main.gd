@tool
extends Node2D

const SIGN = preload("uid://814bsjj47meu")

@export var player_respawn_pos: Vector2:
	set(v):
		player_respawn_pos = v
		queue_redraw()

var sign_started: bool = false
var gone: int = 0
var once: bool = true

@onready var player: Player = $CharacterBody2D as Player


func _ready() -> void:
	if Engine.is_editor_hint(): return
	DialogueManager.dialogue_started.connect(
		func(res: DialogueResource) -> void:
			if res == SIGN: sign_started = true
			player.locked = true
			)
	DialogueManager.dialogue_ended.connect(
		func(res: DialogueResource) -> void:
			if res == SIGN: sign_started = false
			player.locked = false
			)


func _draw() -> void:
	draw_line(player_respawn_pos + Vector2.UP * 10, player_respawn_pos + Vector2.DOWN * 10, Color.BROWN)
	draw_line(player_respawn_pos + Vector2.LEFT * 10, player_respawn_pos + Vector2.RIGHT * 10, Color.BROWN)


func _on_void_body_entered(body: Node2D) -> void:
	if body != player: return
	await get_tree().create_timer(1).timeout
	reset_player()


func _on_sign_body_entered(body: Node2D) -> void:
	if sign_started or body != player: return
	var c: CharacterBody2D = body as CharacterBody2D
	c.velocity = Vector2.ZERO
	DialogueManager.show_dialogue_balloon_scene("uid://15slcyqnh4k2", SIGN, "start", [{"main": self}])


func reset_player() -> void:
	player.global_position = player_respawn_pos
