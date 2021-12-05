extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

func set_hearts(value):
	
	hearts = clamp(value, 0, max_hearts)
	$Hearts.rect_size.x = 32 * hearts

func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	$Hearts.rect_size.x = 32 * hearts
	PlayerStats.connect("health_changed", self, "set_hearts")
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")


func _on_Button_pressed():
	get_tree().change_scene("res://data/levels/Test.tscn")
