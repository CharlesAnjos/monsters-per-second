class_name MobSpawner
extends Node2D

@export var creatures: Array[PackedScene]

@onready var path_follow_2d: PathFollow2D = %PathFollow2D


var monsters_per_minute: float = 60.0
var cooldown: float = 60.0 / monsters_per_minute

func _process(delta):
	if GameManager.is_game_over: return
	# temporizador
	cooldown -= delta
	if cooldown > 0: return
	
	# frequencia definida por monstros por minuto
	var interval = 60.0 / monsters_per_minute
	cooldown = interval
	
	# checar se o ponto é válido
	
	# pegar ponto aleatório
	var point: Vector2 = get_point()
	var world_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = point
	var results: Array = world_state.intersect_point(parameters, 1)
	if not results.is_empty(): return
	
	# instanciar criatura
	# pegar criatura aleatória
	var index = randi_range(0,creatures.size()-1)
	var creature_scene: PackedScene = creatures[index]
	# instanciar cena
	var creature: Node2D = creature_scene.instantiate()
	# colocar na posição
	creature.global_position = point
	# adicionar nó na arvore
	get_parent().add_child(creature)
	

func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.global_position
