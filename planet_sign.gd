extends Sprite

var colors = ["#472D3C","#7A444A","A05B53","BF7958","EEA160","FFFDAF","B6D53C","71AA34","397B44","3C5956","302C2E", "5A5353","7D7071",
				"A0938E","CFC6B8","DFF6F5","8AEBF1","00FAAC","3978A8","39314B","564064","302387","FF3796","FFAEB6","F4B41B","F47E1B","E6482E","A93B3B","827094","4F546B"]



func _ready():
	modulate = Color(colors[randi() % colors.size()])
	Globals.warranty_color = modulate