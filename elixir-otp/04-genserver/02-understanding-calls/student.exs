Code.compile_file("student.ex")

BuildingManager.start_link([])

result = BuildingManager.list_rooms()

IO.puts("\nThe following data was returned from \"list_rooms/0\"")
IO.inspect(result, label: SOLUTION_FILE)