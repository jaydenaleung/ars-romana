extends CharacterBody2D

@export var speed: float = 100.0
var direction := Vector2.ZERO
var last_facing := "forward"  # remembers the last direction for idle

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO

	# --- Movement input ---
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

	# --- Animation selection ---
	if direction == Vector2.ZERO:
		# Idle → use last facing direction
		anim.play("idle-" + last_facing)
	else:
		# Walk → pick animation by direction
		if abs(direction.x) > abs(direction.y):
			# Left/right has priority if horizontal movement is stronger
			if direction.x > 0:
				anim.play("walk-right")
				last_facing = "right"
			else:
				anim.play("walk-left")
				last_facing = "left"
		else:
			# Vertical movement
			if direction.y > 0:
				anim.play("walk-back")
				last_facing = "back"
			else:
				anim.play("walk-forward")
				last_facing = "forward"
				
	print("Player facing: " + last_facing)
