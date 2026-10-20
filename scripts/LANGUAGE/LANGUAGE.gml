#macro DEFAULT_LANGUAGE "English"

global.LANG = DEFAULT_LANGUAGE;
global.LANG_BASE_MAP = {};
global.LANG_TEXT = {};
global.LANG_FONT = {};
global.LANG_SPRITES = {};
global.AVAILABLE_LANG = [];

function directory_files(path, filter) {
	var result = array_create(0);
	var count = 0;

	var filters = [];
	
	if (is_undefined(filter) || filter == "") {
		filters[0] = "*";
	} else if (is_array(filter)) {filters = filter;}
	else {filters[0] = filter;}

	var seen = ds_map_create();
	var pattern, file
	for (var f = 0; f < array_length(filters); f++) {
		pattern = filters[f];
		if (pattern != "*" && string_pos("*", pattern) == 0) {pattern = "*." + pattern;}
		
		file = file_find_first(path + pattern, 0);
		
		while (file != "") {
		    if (!ds_map_exists(seen, file)) {
				ds_map_add(seen, file, true);
				result[count++] = file;
		    }
		    file = file_find_next();
		}
		
		file_find_close();
	}
	
	ds_map_destroy(seen);
	
	return result;
}

function json_to_string(file_path) {
	var buff = buffer_load(file_path);
	var str = buffer_read(buff, buffer_text);
	buffer_delete(buff);
	return str;
}

function lang_directory(lang=global.LANG,folder="") {return $"{working_directory}/lang/{string_lower(lang)}/{folder}/";}
function lang_file(lang=global.LANG) {return lang_directory(lang)+"lang.json";}

function __create_template(filepath,_start="", _middle="", _end="") {
	if (!file_exists(filepath)) {
		var f = file_text_open_write(filepath)
		file_text_write_string(f, _start);
		file_text_writeln(f)
		file_text_write_string(f, "	"+_middle)
		file_text_writeln(f)
		file_text_write_string(f, _end);
		file_text_close(f);
	}
}

function __create_json_template(file, _start="{", _middle="", _end="}") {
	__create_template(file,_start,_middle,_end)
}

function lang_map_update() {
	global.LANG_TEXT={};
	global.LANG_SPRITES={};
	global.LANG_FONT={};
	global.LANG_CACHED_TEXT = {};
	if (directory_exists(lang_directory(global.LANG))) {
		// fonts config
		var config_path = $"{lang_directory(,"fonts")}config.json";
	
		if (file_exists(config_path)) {
			global.LANG_FONT = json_parse(json_to_string(config_path));
			var files = directory_files($"{lang_directory(,"fonts")}",["ttf","otf"])
			var name, file, size
			for(var i = 0; i < array_length(files); i++) {
				name = string_lower(string_copy(files[i],0,string_pos(".",files[i])-1))
				if (!struct_exists(global.LANG_FONT,name)) {struct_set(global.LANG_FONT,name,{})};
			
				file = $"{lang_directory(,"fonts")}{files[i]}"
				size = struct_exists(global.LANG_FONT[$ name],"size") ? global.LANG_FONT[$ name].size : 12
				struct_set(global.LANG_FONT[$ name],"font",font_add(file,size,false,false,32,128))
			}
		} else if (DEVELOPER_MODE) {
			__create_json_template($"{lang_directory(DEFAULT_LANGUAGE,"fonts")}config.json");
		}
	
		// Sprites config
		var sprite_directory = lang_directory(,"sprites");
		if (directory_exists(sprite_directory)) {
			var files = directory_files(sprite_directory,["png","jpeg","jpg","gif"])
			var name;

			for(var i = 0; i < array_length(files); i++) {
				name = string_copy(files[i],0,string_pos(".",files[i])-1);
				if (!struct_exists(global.LANG_SPRITES,name)) {struct_set(global.LANG_FONT,name,undefined)};
				global.LANG_SPRITES[$ name] = sprite_add(sprite_directory+files[i],1,false,false,0,0);
			}
		}
	
		global.LANG_TEXT =  json_parse(json_to_string(lang_file()));
	}
	
	if (directory_exists($"{working_directory}/lang/")) {
		var file = $"{working_directory}/lang/languages.json"
		if (!file_exists(file)) {__create_json_template(file,"[",$"	\"{DEFAULT_LANGUAGE}\"","]")}
		global.AVAILABLE_LANG = json_parse(json_to_string(file))	
	}
}

function lang_setup() {
	if (DEVELOPER_MODE) {
		static prepare_directory = function(folder,language=global.LANG) {
			var p = $"{lang_directory(language)}{folder}";
			if (!directory_exists(p)) {directory_create(p)};
		}

		prepare_directory("sprites",DEFAULT_LANGUAGE);
		prepare_directory("fonts",DEFAULT_LANGUAGE);

		__create_json_template(lang_file(DEFAULT_LANGUAGE),"{","\"Text\": \"Text Example\"","}")
	}

	if (file_exists(lang_file(DEFAULT_LANGUAGE))) {
		global.LANG_BASE_MAP = json_parse(json_to_string(lang_file(DEFAULT_LANGUAGE)));
	}
	lang_map_update();
}

function lang_text(key = "") {
	if (struct_exists(global.LANG_CACHED_TEXT,key)) { //Already cached the text before, so get the cached text (Optization cool)
		return global.LANG_CACHED_TEXT[$ key]
	} else { //Text wasn't chached before, let's grab it
		var parts = string_split(key, ".");
		var sources = [global.LANG_TEXT, global.LANG_BASE_MAP];
	
		for (var s = 0; s < array_length(sources); s++) {
			var node = sources[s];
			var found = true;
		
			for (var i = 0; i < array_length(parts); i++) {
				if (is_struct(node) && struct_exists(node, parts[i])) {
					node = node[$ parts[i]];
				} else {
					found = false;
					break;
				}
			}
		
			if (found) {
				global.LANG_CACHED_TEXT[$ key] = node; //We cached the text for next calls (Optimization i'm so happy)
				return node
			};
		}
	}
	
	return $"Key \"{key}\" not found in \"{string_replace(lang_file(), working_directory + "/", "")}\"";
}

function lang_sprite(sprite_asset) {
	var name = sprite_get_name(sprite_asset)
	if (struct_exists(global.LANG_SPRITES,name)) {
		return global.LANG_SPRITES[$ name]
	} else if (DEVELOPER_MODE) {
		__create_template($"{lang_directory(DEFAULT_LANGUAGE,"sprites")}{name}.template")
	}

	return sprite_asset //Sprite wasn't found, return the input sprite
}

function lang_font(font) {
	var name = font_get_name(font)
	if (!string_count("_newfont",name)) {
		if (struct_exists(global.LANG_FONT,name)) {
			if (struct_exists(global.LANG_FONT[$ name],"font")) {
				return global.LANG_FONT[$ name].font
			}
		} else if (DEVELOPER_MODE) {
			__create_template($"{lang_directory(DEFAULT_LANGUAGE,"fonts")}{name}.template")
		}
	}

	return font //Font wasn't found, return the input font
}
	
function lang_set(_language) {
	global.LANG = _language;
	lang_setup();
}

function draw_lang_font(_font) {
	draw_set_font(lang_font(_font))	
}

lang_set(DEFAULT_LANGUAGE)