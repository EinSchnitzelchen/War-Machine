extends CenterContainer

@export var crosshair_lines : Array[Line2D]
@export var player_controller : CharacterBody3D
@export var crosshair_speed : float = 0.25
@export var crosshair_distance : float = 4 

func _ready() -> void:
	queue_redraw()

func _process(delta: float) -> void:
	move_crosshair_lines()

func _draw():
	draw_circle(Vector2(0,0), 1.0, Color.WHITE)

func move_crosshair_lines():
	var vel = player_controller.get_real_velocity()
	var origin = Vector3(0,0,0)
	var pos = Vector2(0,0)
	var speed = origin.distance_to(vel)
	
	crosshair_lines[0].position = lerp(crosshair_lines[0].position, pos + Vector2(0, -speed * crosshair_distance), crosshair_speed)
	crosshair_lines[1].position = lerp(crosshair_lines[1].position, pos + Vector2(speed * crosshair_distance, 0), crosshair_speed)
	crosshair_lines[2].position = lerp(crosshair_lines[2].position, pos + Vector2(0, speed * crosshair_distance), crosshair_speed)
	crosshair_lines[3].position = lerp(crosshair_lines[3].position, pos + Vector2(-speed * crosshair_distance, 0), crosshair_speed)
	
	
# TODO: set crosshair invis when esc pressed
