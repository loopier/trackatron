class_name Table

#@export var rows := 27
#@export var cols := 123
var matrix := []
var colTemplate := []
var colSeparator := ""

class Cell:
	var digits := 2
	var value := ""

	func _init(minDigits: int = -1):
		digits = max(minDigits, digits)

	func getValue() -> String:
		if value.length() <= 0: return getEmptyText()
		return value
	
	func setValue(newValue: int):
		value = "%0*X" % [digits, value]

	func getEmptyText() -> String:
		var str := ""
		for i in digits: str += "-"
		return str 

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
	var cell = matrix[row][col]
	matrix[row][col].setValue(value)

func getCell(row: int, col: int) -> String:
	return matrix[row][col].getValue()
