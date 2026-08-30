#macro DEVELOPER_MODE true

#macro START_ROOM rm_battle

#macro RESOLUTION 2

#macro BASE_WIDTH 320
#macro BASE_HEIGHT 240

#macro WINDOW_WIDTH (BASE_WIDTH*2)
#macro WINDOW_HEIGHT (BASE_HEIGHT*2)

#macro BORDER_WIDTH (1920/2)
#macro BORDER_HEIGHT (1080/2)

#macro DISPLAY_WIDTH display_get_width()
#macro DISPLAY_HEIGHT display_get_height()

#macro GUI_WIDTH display_get_gui_width()
#macro GUI_HEIGHT display_get_gui_height()

#macro INVENTORY_LIMIT 8

#macro NATIVE_FPS 30
#macro FPS 30
#macro DELTA (NATIVE_FPS/max(1,FPS))

#macro CMD_START "<"
#macro CMD_END ">"

#macro SHAKE_DEFAULT_INTENSITY 1
#macro WAVE_DEFAULT_SPEED 1.5
#macro WAVE_DEFAULT_RANGE 2

#macro DEFAULT_INPUTDELAY 1

#macro fnt_hachiro font_add_sprite_ext(spr_hachiro,"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!?().,",true,0)

#macro EASE_LINEAR "linear"
#macro EASE_OUT "out"
#macro EASE_OUT_BACK "out_back"
#macro EASE_IN "in"
#macro EASE_IN_BACK "in_back"
#macro EASE_IN_OUT "in_out"
#macro EASE_IN_OUT_BACK "in_out_back"
#macro EASE_DAMAGE_TEXT "damage_text"

#macro LINE_BREAK_CHAR "#"