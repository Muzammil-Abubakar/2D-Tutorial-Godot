extends Area2D

@onready var game_manager = %"Game Manager"
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	game_manager.add_point()
	animation_player.play("pickup")
