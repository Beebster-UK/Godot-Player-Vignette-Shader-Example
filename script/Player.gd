extends KinematicBody2D

#If you've allowed 'Resizable' under Display settings you'll need to directly grab this in the _process
onready var screen_dimensions = get_viewport().size 

const SPEED = 240
const FRICTION : float = 5.0
const GRAVITY : float = 9.8

var player_position_uv : Vector2
var velocity = Vector2()
var direction : Vector2

func _ready() -> void:
	VisualServer.set_default_clear_color(Color.gray)


func _process(delta) -> void:
	# convert player position to UV position
	player_position_uv = global_position / screen_dimensions
	# Set shader to player position
	get_parent().get_node("ShaderLayer/Torch").material.set_shader_param("player_position",player_position_uv)
	

func _physics_process(delta) -> void:
	update_movement(delta)
	move_and_slide(velocity)


func update_movement(delta) -> void:	
	if !is_on_floor():
		velocity.y += GRAVITY
	else:
		velocity.y = 0
		
	if get_direction().x != 0:
		velocity.x = get_direction().x * SPEED
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION * delta)


func get_direction() -> Vector2:
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")	
	return direction

