/// @description Seting box Side

text_info = draw_each_letter(txt.x,txt.y,text[curtxt],,,c_black,lang_font(font),.5,.5,0,length,false,writer);

if (instance_exists(target) && side <= -1) {
	if (object_get_parent(target.object_index) == parEnemy || target.object_index == parEnemy) {
		with(target) {
			other.update_bubble()
			var b = other.bubble;
			var txt_offset = other.txt_offset

			while(collision_rectangle(b.x,b.y+other.height,b.x+other.width,b.y,parEnemy,false,true) 
			|| b.x+other.width > room_width-txt_offset.x
			|| b.x+other.width < txt_offset.x
			|| b.y-other.height < txt_offset.x && other.side == SPEECH_SIDE.UP) 
			{
				var p = collision_rectangle(b.x,b.y+other.height,b.x+other.width,b.y,parEnemy,false,true);
				if (!p.in_battle()) {break}
				other.side++
				other.update_bubble();

				if (other.side >= SPEECH_SIDE.DOWN) {break} 
			}
			
		}
	}
}
update_bubble()
update_side()