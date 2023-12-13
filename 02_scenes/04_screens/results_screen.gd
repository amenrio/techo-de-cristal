extends Node2D

func _ready():
	var scoreboard = get_node("detailsLayer/interfaces/statsboxs/Points/Diñeiro ganado2")
	var ingredients = get_node("detailsLayer/interfaces/statsboxs/Alimentos Recollidos/Alimentos Recollidos2")
	var comandas = get_node("detailsLayer/interfaces/statsboxs/Alimentos Recollidos2/Diñeiro ganado3")
	scoreboard.text = str(Autoload.globalScore)
	comandas.text = str(Autoload.totalComandas)
	ingredients.text = str(Autoload.totalIngredients)

func _on_b_menu_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_screens/menu_screen.tscn")


func _on_b_reintentar_pressed():
	get_tree().change_scene_to_file("res://02_scenes/03_levels/level_alpha.tscn")


func _on_b_continuar_pressed():
	$feedbackLayer.visible = false
	$detailsLayer.visible = true
