class_name BezierMultiSpline2D
extends MultiSpline

func sample_multispline(p: float) -> Vector2:
	var length := get_multispline_length()
	assert(length > 0)
	
	if p <= 0:
		return (get_child(0) as Node2D).global_transform.origin
		
	if p >= length:
		return (get_child(get_child_count() - 2) as Node2D).global_transform.origin
	
	var start_idx := int(p) * 2
	return _cubic_bezier(
		(get_child(start_idx) as Node2D).global_transform.origin,
		(get_child(start_idx + 1) as Node2D).global_transform.origin,
		(get_child(start_idx + 3) as Node2D).global_transform.origin,
		(get_child(start_idx + 2) as Node2D).global_transform.origin,
		fmod(p, 1)
	)

# TODO Should be native code, using matrix mult
func _cubic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float) -> Vector2:
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var q2 = p2.lerp(p3, t)

	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)

	var s = r0.lerp(r1, t)
	return s

func get_control_point(idx: int) -> Vector2:
	return (get_child(idx) as Node2D).global_transform.origin

func get_multispline_length() -> int:
	return max(0, (get_child_count() / 2) - 1)
