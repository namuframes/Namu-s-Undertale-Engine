function add_talk(_name,_method) {
	array_push(talk,{name: _name,script: _method})
}	

function add_storage(_item,_cost) {
	array_push(storage,{item: _item, cost: _cost})
}
function add_option(_name, _method) {
	array_push(options,{name: _name, script: _method})	
}

cutscene = noone;
storage = [];
talk = [];
options = [];
can_sell = false

add_option("Buy", function() {set_page(SHOP_OPTIONS.BUY)})
add_option("Sell",function() {
	if (shop.can_sell) {
		set_page(SHOP_OPTIONS.SELL)
	} else {with(shop) {event_user(1)}}
})
add_option("Talk",function() {set_page(SHOP_OPTIONS.TALK)})
add_option("Exit",function() {set_page(SHOP_OPTIONS.EXIT)})


background = undefined
speech = {
	main: "speech.main",
	buying: "speech.\nbuying",
	buyed: "speech.\nbuyed",
	denied: "speech.\ndenied",
	no_cash: "speech.\nno_cash",
	talk: "speech.\ntalk"
}