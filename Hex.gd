class_name Hex

var value := ""
var placeholder := "-"
var default := ""
var header := ""

func _init(digits: int):
	for i in max(1, digits):
		value += placeholder

static func from(number: Variant) -> Hex:
	var hexValue : String = "%X" % number
	var hex := Hex.new(hexValue.length())
	hex.value = hexValue
	return hex

static func withDefault(value: Variant, digits: int = -1) -> Hex:
	var strValue := ""
	if typeof(value) != TYPE_STRING: strValue = "%X" % [value]
	else: 
		strValue = value
		value = value.to_int()
	if digits <= 0: digits = strValue.length()
	var hexValue : String = "%0*X" % [digits, value]
	var hex := Hex.new(digits)
	hex.value = hexValue
	return hex

static func asInt(hex: String) -> int:
	return hex.hex_to_int()

func digits() -> int:
	return value.length()

func set_header(str: String):
	header = str.substr(0, value.length())

func get_header() -> String:
	var str := header
	for i in value.length() - header.length():
		str += " "
	return str

func format(number: Variant, digits: int) -> String:
	return "%0*X" % [digits, number]

func increase() -> String:
	var intValue = max(0, self.toInt() + 1)
	value = format(intValue, value.length())
	return value

func decrease() -> String:
	var intValue = max(0, self.toInt() - 1)
	value = format(intValue, value.length())
	return value

func toInt() -> int:
	return value.hex_to_int()

func zero() -> String:
	placeholder = "0"
	clear()
	return value

func clear() -> String:
	var digits = value.length()
	value = ""
	for i in digits:
		value += placeholder
	return value
