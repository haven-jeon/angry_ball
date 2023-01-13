extends RigidBody2D


var reset = false
var dragging:bool = false
var drag_start: Vector2 = Vector2.ZERO
var drag_end: Vector2 = Vector2.ZERO
var start_position: Vector2 = Vector2.ZERO

@export var impulse_power: int = 70

func _ready() -> void:
    start_position = global_position

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("click") and not dragging:
        dragging = true
        drag_start = get_global_mouse_position()

    if event.is_action_released("click") and dragging:
        dragging = false
        drag_end = get_global_mouse_position()
        var dir = drag_start - drag_end
        apply_central_impulse(dir * impulse_power)




func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    reset = true

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
    if reset:
        state.transform = Transform2D(0.0, start_position)
        state.linear_velocity = Vector2()
        reset = false
