/*
draw_lang_font(fnt_main)
draw_text(10,10,"Instance: " +string(fadeOutInstances))
draw_text(10,25, "Inst Vol: " + string(fadeOutInstVol))
draw_text(10,40, "Inst fadeOutTime: " + string(fadeOutInstTime))
draw_text(10,55, "Song Instance: " + audio_get_name(songInstance))
draw_text(10,70, "Target Song Asset: " + audio_get_name(targetSongAsset))
draw_text(10,100, "Song Asset: " + audio_get_name(songAsset))
draw_set_font(-1)