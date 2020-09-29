defmodule BuildingManager do
    use GenServer

    def start_link(args) do
        GenServer.start_link(__MODULE__, args, name: __MODULE__)
    end

    def init(_args) do
        initial_state = %{rooms: ["The most epic room ~ test"]}
        {:ok, initial_state}
    end

    def list_rooms_manual_implementation() do
        send(__MODULE__, {:send_rooms_info_to, self()})

        receive do
            {:rooms_info, information} -> information
        end
    end

    def handle_info({_send_info, caller}, state) do
        send(caller, {:rooms_info, {state.rooms, :cheers_from, self()}})
        {:noreply, state}
    end
end