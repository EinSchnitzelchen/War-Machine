
extends Control

@onready var animation_player : AnimationPlayer = $AnimationPlayer


var optionsVisible := false 

func _on_options_button_pressed() -> void:
	if optionsVisible:
		animation_player.play("option_slideOut")
		optionsVisible = false 
	else:
		animation_player.play("option_slideIn")
		optionsVisible = true 

# ------------------------------------------------------------------------------------------------ #

func _on_info_button_pressed() -> void:
	print("This is fckin your game, you know whats about lol")


func _on_credits_button_pressed() -> void:
	print("Just me, Dragomy and the Failed Gamejam")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://testmap.tscn")
	Global.time_reset()


func _on_quit_button_pressed() -> void:
	get_tree().quit(0)
