extends Node

@onready var fret_list : Array[Node] = get_tree().get_nodes_in_group("fret")
var parser = MidiFileParser.load_file("res://music/MIDI/test.mid")
var key_order = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
func _on_midi_player_midi_event(channel: Variant, event: Variant) -> void:
	# E4 to C6 are example notes (64 to 83)
	# E2 to C4 are notes that the player has to play (40-59)
	
	# C#4 to D#4 are the count in
	
	if channel.number == 0 and event.type == 144:
		if event['note'] >= 64:
			for fret in fret_list:
				if event['note'] == fret.midi_code:
					fret.play_example()
			pass
		
		elif  event['note'] > 60 and event['note'] < 64:
			if event['note'] == 61:
				print("3...")
			if event['note'] == 62:
				print("2...")
			if event['note'] == 63:
				print("1...")
			
		elif event['note'] <= 60: 
			# listen for player inputs
			pass

func _init() -> void:
	get_midi_timings()

func get_midi_timings() -> Dictionary:
	var midi_timings : Dictionary = {}
	for track in parser.tracks:
		for event in track.events:
			if event.event_type == 3:
				if event.status == 9:
					#print(event.status)
					print(event.absolute_ticks)
					var note = (event.octave + 1) * 12 + key_order.find(event.key)
					print(note)
	return midi_timings
