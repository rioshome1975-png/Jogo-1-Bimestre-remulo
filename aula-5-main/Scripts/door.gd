extends Area2D


@export var next_level = ""

func _on_body_entered(_body: Node2D) -> void:
		call_deferred("change_level")

func change_level():
		get_tree().change_scene_to_file("res://entidades/" + next_level + ".tscn")
