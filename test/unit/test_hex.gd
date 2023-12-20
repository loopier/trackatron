extends GutTest

var hexSrc := load("res://Hex.gd")

func before_all():
	gut.p("Runs once before all tests")

func before_each():
	gut.p("Runs before each test.")

func after_each():
	gut.p("Runs after each test.")

func after_all():
	gut.p("Runs once after all tests")

func test_new():
	assert_eq(Hex.new(0).value, "-")
	assert_eq(Hex.new(2).value, "--")

func test_withDefault():
	assert_eq(Hex.withDefault(0).value, "0")
	assert_eq(Hex.withDefault(0,3).value, "000")
	assert_eq(Hex.withDefault(2,2).value, "02")
	assert_eq(Hex.withDefault(13.5).value, "D")
	assert_eq(Hex.withDefault(13,2).value, "0D")
	assert_eq(Hex.withDefault(13.5, 3).value, "00D")
	assert_eq(Hex.withDefault(132.5).value, "84")

func test_from():
	assert_eq(Hex.from(0).value, "0")
	assert_eq(Hex.from(1000).value, "3E8")
	assert_eq("3E8".hex_to_int(), 1000)
	assert_eq(Hex.from(1000).toInt(), 1000)
	assert_eq(Hex.from(13.5).value, "D")
	assert_eq(Hex.from(13).value, "D")
	assert_eq(Hex.from(132.5).value, "84")

func test_asInt():
	assert_eq(Hex.asInt("F0"), 240)
	assert_eq(Hex.asInt("40"), 64)

func test_increase():
	assert_eq(Hex.from(0).increase(), "1")
	assert_eq(Hex.from(9).increase(), "A")
	assert_eq(Hex.from(15).increase(), "10")
	assert_eq(Hex.from(31).increase(), "20")
	assert_eq(Hex.from(254).increase(), "FF")
	assert_eq(Hex.new(2).increase(), "01")

func test_decrease():
	assert_eq(Hex.from(0).decrease(), "0")
	assert_eq(Hex.from(9).decrease(), "8")
	assert_eq(Hex.from(15).decrease(), "E")
	assert_eq(Hex.from(31).decrease(), "1E")
	assert_eq(Hex.from(254).decrease(), "FD")

func test_zero():
	assert_eq(Hex.from(0).zero(), "0")
	assert_eq(Hex.from(254).zero(), "00")
	assert_eq(Hex.from(1000).zero(), "000")

func test_clear():
	assert_eq(Hex.from(10).clear(), "-")
	assert_eq(Hex.from(1000).clear(), "---")

func test_header():
	var hex = Hex.new(3)
	hex.set_header("bla")
	assert_eq(hex.get_header(), "bla")
	hex.set_header("blafoo")
	assert_eq(hex.get_header(), "bla")
	hex.set_header("b")
	assert_eq(hex.get_header(), "b  ")
	hex = Hex.new(2)
	hex.set_header("bla")
	assert_eq(hex.get_header(), "bl")
