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
	var g = Table.new(2,3)
	assert_eq(g.getEmptyText(), "-- -- --\n-- -- --")
	g = Table.new(3, 2)
	assert_eq(g.getEmptyText(), "-- --\n-- --\n-- --")
	g = Table.new(2, [3, 2, 2])
	assert_eq(g.getEmptyText(), "--- -- --\n--- -- --")

func test_cell():
	var c = Cell.new()
	assert_eq(c.getEmptyText(), "--")
	c = Cell.new(3)
	assert_eq(c.getEmptyText(), "---")
