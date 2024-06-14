extends Node

@export var game_ui: CanvasLayer
@export var game_over_ui_scene: PackedScene

func _ready():
	GameManager.game_over.connect(trigger_game_over)

func trigger_game_over():
	#deletar gameui
	if game_ui:
		game_ui.queue_free()
		game_ui = null
	#instanciar gameoverui
	var game_over_ui: GameOverUI = game_over_ui_scene.instantiate()
	add_child(game_over_ui)
	
