class_name GameOverUI
extends CanvasLayer

@onready var time_label: Label = %TimeLabel
@onready var monster_number_label: Label = %MonsterNumberLabel

@export var restart_delay: float = 5.0
var restart_cooldown: float

func _ready():
	restart_cooldown = restart_delay
	time_label.text = GameManager.elapsed_time_string
	monster_number_label.text = str(GameManager.monsters_defeated_counter)

func _process(delta):
	restart_cooldown -= delta
	if restart_cooldown <= 0.0:
		restart_game()
	
func restart_game():
	GameManager.reset()
	get_tree().reload_current_scene()
