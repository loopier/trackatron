class_name Table

#@export var rows := 27
#@export var cols := 123
var matrix := []
var colTemplate := []
var colSeparator := ""

class Cell:
	var slots := 2
	var contents := ""

	func _init(digits: int = -1):
		slots = max(digits, slots)

	func getEmptyText() -> String:
		var str := ""
		for i in slots: str += "-"
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
