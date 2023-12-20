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

func test_param():
	var param := Zyn.Param.new()
	assert_eq(param.value, 0)
	assert_eq(param.default, 0)
	assert_eq(param.min, 0)
	assert_eq(param.max, 127)
	assert_eq(param.getHex(), "0")
	assert_eq(param.getHexDigits(), 1)
	param = Zyn.Param.new(3)
	assert_eq(param.value, 3)
	assert_eq(param.default, 3)
	assert_eq(param.getHexDigits(), 1)
	param.value = 255
	assert_eq(param.value, 255)
	assert_eq(param.default, 3)
	assert_eq(param.getHex(), "FF")
	assert_eq(param.getHexDigits(), 2)
	param.reset()
	assert_eq(param.value, 3)
	assert_eq(param.getHexDigits(), 1)
	param = Zyn.Param.range(64, 48, 72)
	assert_eq(param.value, 64)
	assert_eq(param.default, 64)
	assert_eq(param.min, 48)
	assert_eq(param.max, 72)
	param = Zyn.Param.range(0.5, 0, 1)
	assert_eq(param.getMidi(), 63.5)
	param.setValue(0.1)
	assert_eq(param.getValue(), 0.1)
	param.setValue(2)
	assert_eq(param.getValue(), 1.0)
	param.value = 4
	assert_eq(param.getValue(), 1.0)
	assert_eq(param.getMidi(), 127)

func test_getMidi():
	var param := Zyn.Param.newWith(5, 0, 10, "/someparam")
	assert_eq(param.getValue(), 5)
	assert_eq(param.min, 0)
	assert_eq(param.max, 10)
	assert_eq(param.getHex(), "5")
	assert_eq(param.getMidi(), 63.5)
	assert_eq(param.getAddr(), "/someparam")
	param = Zyn.Param.newWith(5, 0, 10, "someparam")
	assert_eq(param.getAddr(), "/someparam")
	param = Zyn.Param.newWith(5.5, 0, 127, "someparam")
	assert_eq(param.getMidi(), 5.5)

func test_lfo():
	var LFO := Zyn.LFO
	assert_eq(LFO.SINE, 0)
	var lfo := LFO.new()
	assert_eq(lfo.getFreq().getValue(), 6.49)
	assert_eq(lfo.getFreq().max, 85.25)
	assert_eq(lfo.getFreq().min, 0.08)
	#assert_eq(lfo.getFreq().getMidi(), 9.55817776212281)

func test_hasOsc():
	var osc = Zyn.HasOsc.new()
	assert_eq(osc.getAddr(), "/")
