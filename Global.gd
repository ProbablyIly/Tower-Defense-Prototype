extends Node

@onready var CurrentSelection = null

@onready var Currency = 1.0

func increase_currency():
	Currency += round(Currency)/10
