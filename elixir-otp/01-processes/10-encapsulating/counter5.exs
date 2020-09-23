defmodule Counter do
    defp counter(counter \\ 0) do
        receive do
            :inc -> 
              counter(counter + 1)
            :dec -> 
              counter(counter - 1)
            {:get, pid} -> 
              send(pid, counter)
              counter( counter)
            :reset -> 
              counter(0)
        end
    end

    def start() do
      spawn(&counter/0)
    end

    def inc(counter) do
      send(counter, :inc)
    end

    def dec(counter) do
      send(counter, :dec)
    end

    def reset(counter) do
      send(counter, :reset)
    end

    def get(counter) do
      send(counter, {:get, self()})

      receive do
        answer -> answer
      end
    end
end

counter = Counter.start()

Counter.inc(counter)
Counter.inc(counter)
Counter.inc(counter)
IO.puts(Counter.get(counter))

Counter.dec(counter)
IO.puts(Counter.get(counter))

Counter.reset(counter)
IO.puts(Counter.get(counter))