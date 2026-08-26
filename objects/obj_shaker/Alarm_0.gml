while (initial_value = undefined) {initial_value = variable_instance_get(target,target_variable);}
variable_instance_set(target,target_variable,initial_value+range)
range -= (range*.5)/time*DELTA
range = -range
var o = round(abs(range))
if (o == 0) {instance_destroy()}
alarm[0] = time*FPS/NATIVE_FPS
