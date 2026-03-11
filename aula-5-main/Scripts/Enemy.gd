extends Area2D


func _on_hitbox_body_entered(body):
	if body.name == "Player":
		body.take_damage()


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
