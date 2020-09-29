Code.compile_file("student.ex")

BuildingManager.start_link()

BuildingManager.list_rooms(BuildingManager)
# This should return an empty list
IO.inspect(BuildingManager.list_rooms(BuildingManager))

BuildingManager.add_room(BuildingManager, :d224, 6)
BuildingManager.add_room(BuildingManager, "d223", 4)
BuildingManager.add_room(BuildingManager, :d222, 6)
%{:d224 => 6, "d223" => 4, :d222 => 6} = BuildingManager.list_rooms(BuildingManager)

IO.inspect(BuildingManager.list_rooms(BuildingManager))

Process.exit(BuildingManager, :kill)
BuildingManager.start_link()
BuildingManager.list_rooms(BuildingManager)

IO.inspect(BuildingManager.list_rooms(BuildingManager))
