extends LineEdit

var regex = RegEx.new()
var oldtext = ""

func _ready():
	regex.compile("^[a-zA-Z0-9]{1,15}$")

func _on_Kasutajanimi_text_changed(new_text):
	if regex.search(new_text):
		oldtext = new_text
	else:
		text = oldtext
	set_cursor_position(text.length())
