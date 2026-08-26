function SHOP() constructor {
	storage = [
		{item: new item_stick(),cost: 4},
		{item: new item_stick(),cost: 4},
		{item: new item_stick(),cost: 4},
		{item: new item_stick(),cost: 4}
	]
	
	background = undefined
	
	keeper_instance = undefined
	
	options = [
		{name: "Buy", script: function() {set_page(SHOP_OPTIONS.BUY)}},
		{name: "Sell", script: function() {set_page(SHOP_OPTIONS.SELL)}},
		{name: "Talk", script: function() {set_page(SHOP_OPTIONS.TALK)}},
		{name: "Exit", script: function() {
			if (room != rm_shop) {instance_destroy()} else {
				switch_room(global.saved_player.room)	
			}
		}}
	]
	
	talk = []
	
	static add_talk = function(name,_method) {
		array_push(talk,{name:name,script:_method})
	}

	add_talk("Hello",function() {
		c_dialogue("Wha'sup")
	})
	
	add_talk("Crash",function() {
		c_dialogue("What");
		c_wait_dialogue()
		c_custom(function() {
			audio_play_sound(snd_explosion,0,0)
			show_error("The game closed due to bitchyness",false)
		})
	})
	
	
	
	speech = {
		buying: "Something got'cha eye?",
		buyed: "Thank you!",
		denied: "Alrigh'",
		no_cash: "I'm sorry lil' one, not enough cash.",
		talk: "A chatty eh?<w>\nHit me kiddo"
	}
}

function SHOP_DOGGO() : SHOP() constructor {
	speech = {
		buying: "Get anythin'",
		buyed: "Get more\nGet more!",
		denied: "Awww\nDang it",
		no_cash: "Nope.",
		talk: "What ya need?"
	}
	background = spr_shop_doggo_bg
	keeper_instance = obj_shop_doggo
	talk = []
	add_talk("Pet",function() {
		c_dialogue("Happy doggo")
		c_var(obj_shop_doggo,["image_blend",c_yellow])
		c_wait_dialogue()
		c_var(obj_shop_doggo,["image_blend",c_white])
	})
}