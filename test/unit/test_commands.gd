extends GutTest

var main : Main

func before_all():
	gut.p("Runs once before all tests")

func before_each():
	gut.p("Runs before each test.")
	main = preload("res://main.tscn").instantiate()

func after_each():
	gut.p("Runs after each test.")

func after_all():
	gut.p("Runs once after all tests")

func test_parseCommand():
	assert_eq(main.parseCommand("P0"), "/part0")	
	#assert_eq(main.parseCommand("P0K0AVOf"), "/part0/kit0/adpars/VoicePar0/OscilSmp/Pcurrentbasefunc")
