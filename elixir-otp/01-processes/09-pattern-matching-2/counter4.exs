defmodule Counter do
    def counter(counter \\ 0) do
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
end

pid = spawn(&Counter.counter/0)

send(pid, :inc)
send(pid, :inc)
send(pid, :dec)

send(pid, {:get, self()})
receive do
  answer -> IO.puts(answer)
end