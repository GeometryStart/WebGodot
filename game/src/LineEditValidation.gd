extends LineEdit

var regex = RegEx.new()
var oldtext = ""

func _ready():
	regex.compile("^[0-9]*$")
	
	
func get_value():
	return(int(text))

func _on_Kood_text_changed(new_text):
	if regex.search(new_text):
		oldtext = new_text
	else:
		text = oldtext
	set_cursor_position(text.length())



		
