class_name Table

#@export var rows := 27
#@export var cols := 123
var matrix := []
var colTemplate := []
var colSeparator := ""

class Cell:
	var digits := 1
	var value := ""

	func _init(minDigits: int = -1):
		digits = max(minDigits, digits)

	func getValue() -> String:
		return value
	
	func setValue(newValue: int):
		# do not add extra digits
		newValue = newValue % (16 * digits)
		value = "%0*X" % [digits, newValue]
		if value.length() > digits: value.substr(-digits)

	func getEmptyText() -> String:
		var str := ""
		for i in digits: str += "-"
		return str 

	func getDigits() -> int:
		return digits

func _init(rows: int = 2, cols: Variant = [], separator: String = " "):
	if rows < 1: rows = 2
	if cols is int:
		var numCols : int = cols
		cols = []
		cols.resize(numCols)
		cols.fill(2)
	elif not cols is Array:
		return
	
	colSeparator = separator
	colTemplate = cols
	_buildGrid(rows, colTemplate)

func _buildGrid(rows: int, colTemplate: Array):
	for r in rows:
		var row := []
		for cellSize in colTemplate:
			var cell = Cell.new(cellSize)
			row.append(cell)
		matrix.append(row)

func getRowCount() -> int:
	return matrix.size()

func getColCount() -> int:
	return matrix[0].size()

func getEmptyText() -> String:
	var str := ""
	for row in matrix.size():
		for cell in matrix[row].size():
			str += matrix[row][cell].getEmptyText()
			if cell < matrix[row].size() - 1: str += colSeparator
		if row < matrix.size() - 1: str += "\n"
	return str

func setCell(value: int, row: int, col: int):
	matrix[row][col].setValue(value)

func getCell(row: int, col: int) -> String:
	var value = matrix[row][col].getValue()
	if value == "": return matrix[row][col].getEmptyText()
	return value
