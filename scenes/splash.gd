extends Sprite

func _ready():
	modulate = Color(Globals.colors[randi() % Globals.colors.size()])
	

