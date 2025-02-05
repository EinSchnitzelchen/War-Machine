extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	$"../../Model/Movement"["parameters/conditions/is_running"] = true
	
	
	player.current_speed = player.run_speed
	
func exit():
	$"../../Model/Movement"["parameters/conditions/is_running"] = false
	
func physics_update(delta: float) -> void:
	var input_dir = Input.get_vector("walk_left", "walk_right", "walk_forwards", "walk_backwards")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		pass
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.current_speed)
		player.velocity.z = move_toward(player.velocity.z, 0, player.current_speed)
	var y_velocity = player.velocity.y
	player.velocity.y = 0.0
	player.velocity = player.velocity.lerp(direction * player.current_speed, player.ACCELERATION * player.FRICTION * delta)
	player.velocity.y = y_velocity
	
	$"../../Model/Movement"["parameters/Run/blend_position"] = input_dir
	
	$"../../Model/Movement".set("parameters/Run/0/TimeScale/scale",  player.ACCELERATION * player.FRICTION / 3)
	$"../../Model/Movement".set("parameters/Run/1/TimeScale/scale",  player.ACCELERATION * player.FRICTION / 3)
	$"../../Model/Movement".set("parameters/Run/2/TimeScale/scale",  player.ACCELERATION * player.FRICTION / 3)
	$"../../Model/Movement".set("parameters/Run/3/TimeScale/scale",  player.ACCELERATION * player.FRICTION / 3)
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_just_released("sprint"):
		finished.emit(WALKING)
	elif player.velocity == Vector3(0,0,0):
		finished.emit(IDLE)
