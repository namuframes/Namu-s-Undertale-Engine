randomise()
game_set_speed(FPS,gamespeed_fps);
window_set_size(WINDOW_WIDTH,WINDOW_HEIGHT)
window_center()
display_reset(0,true)


surface_resize(application_surface,BASE_WIDTH*RESOLUTION,BASE_HEIGHT*RESOLUTION)
application_surface_draw_enable(false)
font_add_enable_aa(false)
global.TYPEWRITER_EVENT = ds_map_create();


//--------------- PRELOAD -------------------
//You can use sprite_prefetch(sprite)