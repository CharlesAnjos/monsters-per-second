extends Node

@export var speed: float = 1
var sprite: AnimatedSprite2D
var enemy: Enemy
var input_vector = Vector2(0,0)

func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("AnimatedSprite2D")
	print(enemy.health)

func _process(delta):
	if GameManager.is_game_over: return
	rotate_sprite()

func _physics_process(delta: float) -> void:
	var player_position = GameManager.player_position
	var difference = player_position - enemy.position
	input_vector = difference.normalized()
	enemy.velocity = input_vector * speed * 100.0
	enemy.move_and_slide()

func rotate_sprite():
# girar sprite
	if input_vector.x > 0:
		sprite.flip_h = false
	elif input_vector.x < 0:
		sprite.flip_h = true
