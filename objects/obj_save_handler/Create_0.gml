depth = LAYER.UI;
options = [
	{text:"Start", script: function(){
		audio_play_sound(snd_save,0,0);
		create_dialogue("<finish><#595959>* (Haven't actually saved.\ncheck obj_save_hander.)");
	}},
	{text:"Return", script:""},
]
hrt = spr_small_heart
index = 0;