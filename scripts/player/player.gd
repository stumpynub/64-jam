class_name Player extends CharacterBody3D


const SPEED = 50.0
const JUMP_VELOCITY = 4.5
enum fearstates {fear0, fear1, fear2, fear3, fear4}

@export var cam: Camera3D


@onready var flashlight = %Flashlight
@onready var UI = $UI
@onready var isPaused = false
@onready var spooky = $"../NavigationRegion3D/AI"
@onready var spookystillinframe = false
@onready var timer = $Timer


func _ready() -> void:
	pass
	

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
		pass #fearMeter()
		
	if event.is_action_pressed("escape"):
		pause()


func jump(): 
	if !is_on_floor(): return 
	velocity.y = 10 

func seenspooky(distance):
	spookystillinframe = true	
	fearMeter(distance)

func spookygone(distance):
	spookystillinframe = false	
	fearMeter(distance)

func fearMeter(distance):
	var distancemultiplier = determine_distance_multiplier(distance)
	if spookystillinframe:
		UI._increaseFearMeter(15, distancemultiplier)
		timer.start(1)
	else:
		UI._decreaseFearMeter()

func determine_distance_multiplier(distance):
	print(distance)
	if distance >= 100:
		return 100
	elif distance > 75:
		return 80
	elif distance > 50:
		return 60
	elif distance > 25:
		return 10
	elif distance > 10:
		return 8
	else:
		return 6

func toggle_flashlight(): 
	flashlight.visible = !flashlight.visible

func pause():
	if isPaused == false:
		get_tree().paused = true
		UI._pauseMenu(true)
		isPaused = true
	else:
		get_tree().paused = false
		UI._pauseMenu(false)
		isPaused = false


func _on_timer_timeout() -> void:
	fearMeter(spooky.get_distance())
