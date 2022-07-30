extends Area2D

signal hit

export var speed = 400
var screen_size

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var vel = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		vel.x = vel.x - 1
	if Input.is_action_pressed("move_right"):
		vel.x = vel.x + 1
	if Input.is_action_pressed("move_down"):
		vel.y = vel.y + 1
	if Input.is_action_pressed("move_up"):
		vel.y = vel.y - 1
	
	if vel.length() > 0:
		vel = vel.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	if vel.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = vel.x < 0
	elif vel.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = vel.y > 0
		
		
	position = position + vel * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
		

func _on_Player_body_entered(body):
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_PlayerNode_hit():
	hide()
