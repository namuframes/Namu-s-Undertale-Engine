if (is_method(destroy_method)) {
	with(creator) {
		script_execute(other.destroy_method)
	}
};