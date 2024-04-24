extends Control

const VU_COUNT = 13
const HEIGHT = 60
const FREQ_MAX = 11050.0

const MIN_DB = 60

var playing = false

@onready
var spectrum = AudioServer.get_bus_effect_instance(1,0)

@onready
var bottomRightArray = $MusicPlayer/CircleBase/Right/Bottom.get_children()

@onready
var topRightArray = $MusicPlayer/CircleBase/Right/Top.get_children()

func _ready():
	pass

func _process(_delta):
	
	var prev_hz = 0
	for i in range(1,VU_COUNT+1):   
		var hz = i * FREQ_MAX / VU_COUNT;
		var f = spectrum.get_magnitude_for_frequency_range(prev_hz,hz)
		var energy = clamp((MIN_DB + linear_to_db(f.length()))/MIN_DB,0,1)
		var height = energy * HEIGHT
 
		prev_hz = hz

		var bottomRightRect = bottomRightArray[i - 1]
		var topRightRect = topRightArray[i - 1]

		# Set the color of the rectangles based on the energy level
		var color = Color()
		if energy < 0.5:
			color = Color(1, 0, 0)
		elif energy < 0.8:
			color = Color(0, 1, 0)
		else:
			color = Color(0, 0, 1)

		bottomRightRect.modulate = color
		topRightRect.modulate = color

		var tween = get_tree().create_tween()
		tween.tween_property(bottomRightRect, "size", Vector2(bottomRightRect.size.x, height), 0.05)
		tween.tween_property(topRightRect, "size", Vector2(topRightRect.size.x, height), 0.05)
