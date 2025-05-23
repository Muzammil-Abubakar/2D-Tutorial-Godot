extends Node2D

const SPEED = 60
@onready var right = $Right
@onready var left = $Left
@onready var animated_sprite_2d = $AnimatedSprite2D

var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x += direction * SPEED * delta
