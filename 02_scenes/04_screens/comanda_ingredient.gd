extends Control

var ing_sprite: String

var sprites:Dictionary = {
	"chocolate":"res://01_assets/01_sprites/ingredientes/chocolate.png",
	"masa":"res://01_assets/01_sprites/ingredientes/masa.png",
	"naranja":"res://01_assets/01_sprites/ingredientes/naranja.png"
	
}
func _ready():
	$MarginContainer/sprite.texture = load(sprites[ing_sprite])
