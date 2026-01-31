extends Node

@onready var fret_list : Array[Node] = get_tree().get_nodes_in_group("fret")

func _on_midi_player_midi_event(channel: Variant, event: Variant) -> void:
	# E4 to C6 are example notes (64 to 83)
	# E2 to C4 are notes that the player has to play (40-59)
	if channel.number == 0 and event.type == 144:
		print(event['note'])
		if event['note'] >= 64:
			for fret in fret_list:
				if event['note'] == fret.midi_code:
					fret.play_example()
			pass
		
		elif event['note'] <= 60: 
			# listen for player inputs
			pass
