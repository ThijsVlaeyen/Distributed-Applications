defmodule BuildingManager do
    use GenServer

    def start_link(args) do
        GenServer.start_link(__MODULE__, args, name: __MODULE__)
    end

    def list_rooms do
        GenServer.call(__MODULE__, {:room_info, :please})
    end

    def init(_args) do
        initial_state = %{rooms: []}
        {:ok, initial_state}
    end

    def handle_call({:room_info, :please}, _from, state) do
        {:reply, state.rooms, state}
    end
end