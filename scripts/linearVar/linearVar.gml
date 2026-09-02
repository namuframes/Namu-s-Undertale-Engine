// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function linearVar(_var,_value, _gain=1){
	_gain *= DELTA()
    var dif = _value - _var;
    var step = _gain * sign(dif);

    return abs(dif) < abs(step) ? _value : _var + step;
}
