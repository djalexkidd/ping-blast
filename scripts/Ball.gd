extends KinematicBody2D

var velocity = Vector2(100,0)
var strengh = 50 #Compteur
const GRAVITY = 5 #Gravité

signal add_score
signal spawn_small

#Couleurs aléatoires
const colors = [Color(1.0, 0.0, 0.0),
		  Color(0.0, 1.0, 0.0),
		  Color(0.0, 0.0, 1.0),
		  Color(1.0, 1.0, 1.0)]

func _ready():
	randomize() #Initialise le générateur de nombre aléatoire
	modulate = colors[randi() % colors.size()] #Change la couleur aléatoirement
	$Strengh.text = String(strengh) #Actualise le compteur
	connect("add_score", get_node("../CanvasLayer/HUD"), "_on_Ball_add_score")
	if is_in_group("ball"):
		connect("spawn_small", get_node(".."), "_on_Ball_spawn_small")

#Pour faire rebondir
func _physics_process(delta):
	velocity.y += GRAVITY
	move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		velocity.x *= -1
		$Bounce.play()
	if is_on_floor():
		velocity.y *= -1
		$Bounce.play()
	
	#Disparait quand le compteur est à 0
	if strengh == 0:
		emit_signal("spawn_small")
		queue_free()

#Décrémente le compteur
func _on_Area2D_area_entered(area):
	if not area.is_in_group("Player"):
		strengh -= 1
		emit_signal("add_score")
		$Strengh.text = String(strengh) #Actualise le compteur
