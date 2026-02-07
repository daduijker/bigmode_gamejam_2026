extends Node

@onready var fret_list : Array[Node] = get_tree().get_nodes_in_group("fret")
@onready var licks : Array[Node] = get_tree().get_nodes_in_group("lick")
@onready var NoteManager : Node = get_tree().get_first_node_in_group("NoteManager")
@onready var GameManager : Node = get_tree().get_first_node_in_group("GameManager")
@onready var midi_player: MidiPlayer = $MidiPlayer
@onready var metronome: AudioStreamPlayer2D = $Metronome
@onready var midi_timings : Dictionary = {}



var parser = MidiFileParser.load_file("")
var key_order = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
var time_passed : int
var playing_lick : bool = false



func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	time_passed += delta * 1000
	
	# check if a note has been played too late:
	if playing_lick:
		for note in midi_timings:
			if time_passed > note + GameManager.note_timing_threshold:
				# YOU MISSED A NOTE
				#print_debug('YOU MISSED A NOTE')
				GameManager.lick_unsuccessful()
	
func start_new_lick() -> void:
	playing_lick = true
	time_passed = 0
	connect_lick(select_lick(GameManager.difficulty, GameManager.difficulty_threshold))
	
func stop_lick() -> void:
	playing_lick = false
	midi_player.stop()
	midi_timings = {}

func select_lick(difficulty_score, difficulty_threshold) -> Lick:
	# Selects a lick with difficulty score +- threshold at random, or selects a random lick
	var possible_licks = []
	for lick in licks:
		if lick.difficulty + difficulty_threshold < difficulty_score or \
		lick.difficulty - difficulty_threshold:
			possible_licks.append(lick)
	if possible_licks:
		return possible_licks.pick_random()
	else: 
		return licks.pick_random()

func connect_lick(lick: Lick):
	parser = MidiFileParser.load_file(lick.lick_midi)
	print(get_midi_timings(lick.bmp))
	midi_player.file = lick.lick_midi
	midi_player.play()

func player_played_note(note : int) -> void:
	#print(time_passed)
	for timing in midi_timings:
		if time_passed - GameManager.note_timing_threshold < timing and \
		time_passed + GameManager.note_timing_threshold > timing:
			#print(midi_timings[timing])
			#print(note)
			if midi_timings[timing] == note - 24:
				for fret in fret_list:
					if note == fret.midi_code:
						fret.play_note()
				midi_timings.erase(timing)

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
			metronome.play()
			#if event['note'] == 61:
				#print("3...")
			#if event['note'] == 62:
				#print("2...")
			#if event['note'] == 63:
				#print("1...")
		elif  event['note'] == 60:
			#LICK COMPLETED
			GameManager.lick_successful()
		
		elif event['note'] < 60: 
			# PLAYER INPUT GETS HANDLED ELSEWHERE
			pass

func get_midi_timings(bpm) -> Dictionary:
	var tps = bpm * 480 / 60
	midi_timings = {}
	#print(tps)
	for track in parser.tracks:
		for event in track.events:
			if event.event_type == 3:
				if event.status == 9:
					#print(event.status)
					var timing : float = (event.absolute_ticks * 1000 / tps)
					
					#print(timing)
					#print(event.absolute_ticks)
					var note = (event.octave + 1) * 12 + key_order.find(event.key)
					#print(note)
					if note < 60:
						midi_timings[timing] = note
	return midi_timings
