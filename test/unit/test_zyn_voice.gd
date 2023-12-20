extends GutTest

var zynSrc := load("res://Zyn.gd")

func before_all():
	gut.p("Runs once before all tests")

func before_each():
	gut.p("Runs before each test.")

func after_each():
	gut.p("Runs after each test.")

func after_all():
	gut.p("Runs once after all tests")

func test_voice():
	var voice : Zyn.Voice = Zyn.Voice.new()
	assert_eq(voice.amp.vol.getValue(), 64)
	assert_eq(voice.amp.vol.getHex(), "40")
