extends Node

@onready var LickManager : Node
@onready var NoteManager : Node
@onready var GameManager : Node
@onready var GameSize : Vector2 = get_window().size
@onready var spawn_animation = preload("res://scenes/spawn_animation.tscn")
