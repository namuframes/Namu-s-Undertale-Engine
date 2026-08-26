function draw_hp(x,y,w,h,current,_max,front_color,back_color,outline=1.5,mincolor=front_color){
	draw_rectangle_color(x-outline,y-outline,(x+w)+outline,(y+h)+outline,c_black,c_black,c_black,c_black,false)
	draw_healthbar(x,y,x+w,y+h,(current/_max)*100,back_color,mincolor,front_color,0,true,false)
}