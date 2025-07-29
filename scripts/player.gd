class_name Player
extends CharacterBody2D

@export var movement_speed: float = 300.0
@export var dash_speed: float = 800
@export var dash_duration: float = 0.3
@export var dash_cooldown: float = 3.0
@export var attack_cooldown_duration: float = 0.5

var can_dash: bool = true
var can_attack: bool = true

func _physics_process(delta: float) -> void:
	move_and_slide()
