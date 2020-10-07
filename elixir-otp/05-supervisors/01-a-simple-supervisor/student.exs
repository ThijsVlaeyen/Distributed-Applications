workers = [A, B, C]
supervisor = SUP

defmodule Employee do
    use GenServer

    def start_link(args), do: GenServer.start_link(__MODULE__, init_args, name: [NAME])
    def init(args), do: {:ok, starting_state} # {:continue, :to_be_matched_upon} could be the 3rd element of the tuple

    def add_work(emp, amount), do: GenServer.cast(emp, {:addwork, amount})
    def handle_cast({:addwork, n}, s), do: {:noreply, newstate}
end