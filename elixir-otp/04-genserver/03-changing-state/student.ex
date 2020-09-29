defmodule BuildingManager do
    use GenServer
    @me __MODULE__
    defstruct rooms: %{}

    def start_link(args \\ []) do
        GenServer.start_link(@me, args, name: @me)
    end

    def list_rooms(pid) do
        GenServer.call(pid, {:room_info, :please})
    end

    def add_room(pid, room_name, max_people) 
        when (is_atom(room_name) or is_binary(room_name)) and is_integer(max_people) and max_people > 0 do
        GenServer.cast(pid, {:add_room, room_name, max_people})
    end

    def delete_room(pid, room_name)
        when (is_atom(room_name) or is_binary(room_name)) do
        GenServer.cast(pid, {:delete_room, room_name})
    end


    def init(_args) do
        {:ok, %@me{}}
    end

    # HANDLERS
    def handle_call({:room_info, :please}, _from, %@me{} = state) do
        {:reply, state.rooms, state}
    end

    def handle_cast({:add_room, room_name, max_people}, %@me{} = state)
        when (is_atom(room_name) or is_binary(room_name)) and is_integer(max_people) and max_people > 0 do
        new_rooms = Map.put(state.rooms, room_name, max_people)
        {:noreply, %{state | rooms: new_rooms}}
    end

    def handle_cast({:delete_room, room_name}, %@me{} = state)
        when is_atom(room_name) or is_binary(room_name) do
        new_rooms = Map.delete(state.rooms, room_name)
        {:noreply, %{state | rooms: new_rooms}}
    end
end