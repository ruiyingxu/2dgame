extends Control

@onready var rabbit = $Rabbit
@onready var alice_sprite = $AliceSprite
@onready var alice_falling = $AliceFalling
@onready var mushroom = $Mushroom
@onready var poision = $Poision

@onready var rabbit_rush = $RabbitRush
@onready var dialogue_box = $DialogueBox
@onready var options_container = $DialogueBox/MarginContainer/VBoxContainer/OptionsContainer
@onready var speaker_name = $DialogueBox/MarginContainer/VBoxContainer/SpeakerName
@onready var dialogue_text = $DialogueBox/MarginContainer/VBoxContainer/DialogueText
@onready var stage_direction = $DialogueBox/MarginContainer/VBoxContainer/StageDirection
@onready var option1 = $DialogueBox/MarginContainer/VBoxContainer/OptionsContainer/Option1
@onready var option2 = $DialogueBox/MarginContainer/VBoxContainer/OptionsContainer/Option2
var rabbit_pos = 0.0
var show_options = false
var rabbit_moving = true
var current_scene = 0
var dialogue_index = 0
var tweedle_dialogues = [
	{"speaker": "Tweedledum", "text": "Contrariwise, if it was so, it might be; and if it were so, it would be; but as it isn't, it ain't. That's logic."},
	{"speaker": "Tweedledee", "text": "(clapping hands) If you think we're waxworks, you ought to pay, you know."},
	{"speaker": "Alice", "text": "(confused) I never said you were waxworks!"},
	{"speaker": "Tweedledum", "text": "The Walrus and the Carpenter were walking close at hand; They wept like anything to see Such quantities of sand…"},
	{"speaker": "Alice", "text": "Are you reciting poetry?"},
	{"speaker": "Tweedledee", "text": "It's a very sad story."},
	{"speaker": "Tweedledum", "text": "The Walrus and the Carpenter invite the oysters to take a walk. The oysters follow them…"},
	{"speaker": "Alice", "text": "That was very kind of them."},
	{"speaker": "Tweedledee", "text": "(shaking head) Not at all. They ate them all."},
	{"speaker": "Alice", "text": "Oh! That was dreadful!"},
	{"speaker": "Tweedledum", "text": "The Walrus felt sorry…"},
	{"speaker": "Tweedledee", "text": "But he ate more than the Carpenter."}
]
var flower_dialogues = [
	{"speaker": "Rose", "text": "Who is that wandering creature?"},
	{"speaker": "Daisy", "text": "She has no petals."},
	{"speaker": "Lily", "text": "And no fragrance. How unfortunate."},
	{"speaker": "Alice", "text": "I'm sorry. I was only looking for the way out."},
	{"speaker": "Rose", "text": "Looking? Flowers do not look. We bloom."},
	{"speaker": "Tulip", "text": "We stand still and are admired."},
	{"speaker": "Flowers", "text": "(singing) We bloom in rows, we bloom in rhyme, We measure space, we measure time. We face the sun, we never roam, The garden is our perfect home."},
	{"speaker": "Alice", "text": "It's very beautiful… but don't you ever wish to see something beyond the garden?"},
	{"speaker": "Rose", "text": "Beyond?"},
	{"speaker": "Daisy", "text": "How improper."},
	{"speaker": "Lily", "text": "Movement suggests instability."},
	{"speaker": "Flowers", "text": "(singing louder) Rooted deep, we never stray, The earth decides where we will stay. To wander wild is quite absurd, A roaming stem is most unheard."},
	{"speaker": "Alice", "text": "But I'm not a flower. I don't have roots."},
	{"speaker": "Rose", "text": "That is precisely the problem."},
	{"speaker": "Tulip", "text": "No roots. No symmetry."},
	{"speaker": "Lily", "text": "No belonging."},
	{"speaker": "Daisy", "text": "She bends the air around her."},
	{"speaker": "Rose", "text": "You are disturbing the arrangement."},
	{"speaker": "Flowers", "text": "(chanting) Out of place. Out of line. Out of pattern. Out of design."},
	{"speaker": "Alice", "text": "I didn't mean to disturb anything."},
	{"speaker": "Lily", "text": "Intention does not matter."},
	{"speaker": "Rose", "text": "This garden is not for wandering things."},
	{"speaker": "Flowers", "text": "(stronger) Back to the path. Back to the stone. Find a world That is your own."},
	{"speaker": "Alice", "text": "I'll go."},
	{"speaker": "Rose", "text": "Good."},
	{"speaker": "Daisy", "text": "She was never meant to bloom here."}
]

func _ready():
	dialogue_box.gui_input.connect(_on_dialogue_box_input)
	option1.pressed.connect(_on_option1_pressed)
	option2.pressed.connect(_on_option2_pressed)

func _process(delta):
	if rabbit_moving:
		rabbit_pos += delta * 200
		rabbit.position.x = rabbit_pos
		if rabbit_pos > get_viewport_rect().size.x + 100:
			rabbit_pos = -100

func _on_dialogue_box_input(event):
	if event is InputEventMouseButton and event.pressed:
		if not show_options and current_scene == 0:
			show_options = true
			speaker_name.visible = false
			dialogue_text.visible = false
			stage_direction.visible = false
			rabbit.visible = false
			alice_sprite.visible = true
			options_container.visible = true
		elif current_scene == 1 or current_scene == 5:
			current_scene = 2
			speaker_name.visible = false
			dialogue_text.visible = false
			stage_direction.visible = false
			alice_falling.visible = false
			rabbit_rush.visible = false
			mushroom.visible = true
			poision.visible = true
			option1.text = "Eat the mushroom"
			option2.text = "Drink the poison"
			option1.visible = true
			option2.visible = true
			options_container.visible = true
		elif current_scene == 3:
			current_scene = 9
			speaker_name.visible = false
			dialogue_text.visible = false
			stage_direction.visible = false
			option1.text = "Meet Tweedledee and Tweedledum"
			option2.text = "Meet the flowers"
			option1.visible = true
			option2.visible = true
			options_container.visible = true
		elif current_scene == 4:
			current_scene = 10
			speaker_name.visible = true
			dialogue_text.visible = true
			stage_direction.visible = false
			speaker_name.text = "Alice"
			dialogue_text.text = "Oh No! I cannot reach the key"
		elif current_scene == 10:
			current_scene = 6
			speaker_name.visible = false
			dialogue_text.visible = false
			stage_direction.visible = false
			mushroom.visible = true
			poision.visible = false
			option1.text = "Eat the mushroom"
			option1.visible = true
			option2.visible = false
			options_container.visible = true
		elif current_scene == 7:
			if dialogue_index < tweedle_dialogues.size():
				var dialogue = tweedle_dialogues[dialogue_index]
				speaker_name.text = dialogue["speaker"]
				dialogue_text.text = dialogue["text"]
				dialogue_index += 1
			else:
				speaker_name.visible = false
				dialogue_text.visible = false
				dialogue_text.text = "Story finished!"
		elif current_scene == 8:
			if dialogue_index < flower_dialogues.size():
				var dialogue = flower_dialogues[dialogue_index]
				speaker_name.text = dialogue["speaker"]
				dialogue_text.text = dialogue["text"]
				dialogue_index += 1
			else:
				speaker_name.visible = false
				dialogue_text.visible = false
				dialogue_text.text = "Flower scene finished!"


func _on_option1_pressed():
	if current_scene == 0:
		current_scene = 1
		options_container.visible = false
		alice_sprite.visible = false
		alice_falling.visible = true
		speaker_name.visible = true
		dialogue_text.visible = true
		stage_direction.visible = true
		speaker_name.text = ""
		dialogue_text.text = "Alice falls into a rabbit hole and found a small door"
		stage_direction.text = "(there's a key on the table)"
	elif current_scene == 2:
		current_scene = 3
		mushroom.visible = false
		poision.visible = false
		options_container.visible = false
		speaker_name.visible = true
		dialogue_text.visible = true
		stage_direction.visible = false
		speaker_name.text = ""
		dialogue_text.text = "Get the key and become small, flood through the door"
	elif current_scene == 6:
		mushroom.visible = false
		options_container.visible = false
		speaker_name.visible = true
		dialogue_text.visible = true
		stage_direction.visible = false
		speaker_name.text = ""
		dialogue_text.text = "Alice become bigger, get the key and become small, go through the door with flood"
	elif current_scene == 9:
		current_scene = 7
		dialogue_index = 0
		options_container.visible = false
		speaker_name.visible = true
		dialogue_text.visible = true
		stage_direction.visible = false
		var dialogue = tweedle_dialogues[dialogue_index]
		speaker_name.text = dialogue["speaker"]
		dialogue_text.text = dialogue["text"]
		dialogue_index += 1

func _on_option2_pressed():
	if current_scene == 0:
		current_scene = 5
		options_container.visible = false
		alice_sprite.visible = false
		speaker_name.visible = true
		dialogue_text.visible = true
		speaker_name.text = "Rabbit"
		dialogue_text.text = "Come ON! We are late!"
		stage_direction.visible = false
		rabbit.visible = false
		rabbit_rush.visible = true
	elif current_scene == 2:
		current_scene = 4
		mushroom.visible = false
		poision.visible = false
		options_container.visible = false
		speaker_name.visible = true
		dialogue_text.visible = true
		stage_direction.visible = false
		speaker_name.text = ""
		dialogue_text.text = "Alice become smaller"
	elif current_scene == 6:
		mushroom.visible = false
		options_container.visible = false
		speaker_name.visible = true
		dialogue_text.visible = true
		stage_direction.visible = false
		speaker_name.text = ""
		dialogue_text.text = "Alice become smaller and go through the door"
	elif current_scene == 9:
		current_scene = 8
		dialogue_index = 0
		options_container.visible = false
		speaker_name.visible = true
		dialogue_text.visible = true
		stage_direction.visible = false
		var dialogue = flower_dialogues[dialogue_index]
		speaker_name.text = dialogue["speaker"]
		dialogue_text.text = dialogue["text"]
		dialogue_index += 1
