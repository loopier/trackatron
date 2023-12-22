extends GutTest

var Table := load("res://Table.gd")
var Cell = Table.Cell

func before_all():
	gut.p("Runs once before all tests")

func before_each():
	gut.p("Runs before each test.")

func after_each():
	gut.p("Runs after each test.")

func after_all():
	gut.p("Runs once after all tests")

func test_table():
	var t = Table.new(2,3)
	assert_eq(t.getEmptyText(), "-- -- --\n-- -- --")
	t = Table.new(3, 2)
	assert_eq(t.getEmptyText(), "-- --\n-- --\n-- --")
	t = Table.new(2, [3, 2, 2])
	assert_eq(t.getEmptyText(), "--- -- --\n--- -- --")

func test_cell():
	var c = Cell.new()
	assert_eq(c.getEmptyText(), "--")
	assert_eq(c.getDigits(), 2)
	c = Cell.new(3)
	assert_eq(c.getEmptyText(), "---")
	assert_eq(c.getDigits(), 3)

func test_cell_value():
	var c = Cell.new()
	c.setValue(0)
	assert_eq(c.getValue(), "0")
	c.setValue(16)
	assert_eq(c.getValue(), "0")
	c = Cell.new(2)
	c.setValue(16)
	assert_eq(c.getValue(), "10")
	c.setValue(33)
	assert_eq(c.getValue(), "01")
	c = Cell.new(2)
	c.setValue(0)
	assert_eq(c.getValue(), "00")

func test_getCell():
	var t = Table.new(2,[3, 2])
	assert_eq(t.getCell(0,0), "---")
	assert_eq(t.getCell(0,1), "--")

func test_setCell():
	var t = Table.new(2,[3,2])
	t.setCell(0, 0, 0)
	assert_eq(t.getCell(0,0), "000")
	t.setCell(15, 0, 1)
	assert_eq(t.getCell(0,0), "000")
	assert_eq(t.getCell(0,1), "0F")
	t.setCell(33, 0, 1)
	assert_eq(t.getCell(0,1), "01")
