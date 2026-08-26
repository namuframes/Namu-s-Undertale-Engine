function font_rule(_font){
	var output = {
		xoffset: 0,
		yoffset: 0
	}
	switch(_font) {
		case fnt_comic_sans:
			output.yoffset=3
		break;
	}
	return output
}