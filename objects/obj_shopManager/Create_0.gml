
setup_menu()
depth = DEPTHS.UI
shop = parShopKeeper

speech = ""
storage = []
options = []
talk = []

page.current = -1

buy_speak = "";

main_text = new typer()
main_text.skipable = false

right_text = new typer()
right_text.skipable = false

buy_state = 0
buy_options = [
	"Yes",
	"No"
]
choosen_item_index = 0
offy=75
oneshot = true
cutscene = undefined;
txt = {x: 0,	y: 0}

depth = 0
in_cutscene = undefined;