extends Node2D
var result_message: Dictionary = {
	"BAD" : "Non diches pancada. 
	Faralo mellor á próxima?.",
	"NORMAL": "Querida, apenas fixeches o teu traballo,
	non te des tanto mérito.",
	"EXCELENT" :"Non tiña expectativas en ti tonta,
	pero fixéchelo ben hoxe...	Grazas."
}
var result_img: Dictionary = {
	"BAD" : "res://01_assets/01_sprites/02_ilustraciones/placeholder_derrota_normalRes.png",
	"NORMAL": "res://01_assets/01_sprites/02_ilustraciones/placeholder_normal_normalRes.png",
	"EXCELENT" :"res://01_assets/01_sprites/02_ilustraciones/placeholder_victoria_normalRes.png"
}
func _ready():
	AudioAutoload.playIntro()
	var result_text = $feedbackLayer/interfaces/feedbackBox/feedbackText
	var scoreboard = get_node("detailsLayer/interfaces/statsboxs/Points/Diñeiro ganado2")
	var ingredients = get_node("detailsLayer/interfaces/statsboxs/Alimentos Recollidos/Alimentos Recollidos2")
	var comandas = get_node("detailsLayer/interfaces/statsboxs/Alimentos Recollidos2/Diñeiro ganado3")
	var img_result = $feedbackLayer/interfaces/illustration_top
	img_result.texture = load(result_img[Autoload.result])
	result_text.text = str(result_message[Autoload.result])
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
