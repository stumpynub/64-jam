class_name Player extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


@export var cam: Camera3D


@onready var flashlight = %Flashlight
@onready var UI = $UI
@onready var isPaused = false
@onready var spooky = $"../NavigationRegion3D/AI"

func _ready() -> void:
	print(spooky.has_signal("screen_entered"))
	

#TODO add dampening 
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var direction := (cam.global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('jump'): 
		jump()
		
	if event.is_action_pressed("flashlight"): 
		toggle_flashlight()
		
	if event.is_action_pressed("interact"):
		fearMeter()
		
	if event.is_action_pressed("escape"):
		seenspooky()
		#pause()
		
		


func jump(): 
	if !is_on_floor(): return 
	velocity.y = 10 

func fearMeter():
	UI._updateFearMeter(15, 2)

func toggle_flashlight(): 
	flashlight.visible = !flashlight.visible

func pause():
	print(get_tree().paused)
	if isPaused == false:
		get_tree().paused = true
		UI._pauseMenu(true)
		isPaused = true
	else:
		get_tree().paused = false
		UI._pauseMenu(false)
		isPaused = false

func seenspooky():
	fearMeter()
