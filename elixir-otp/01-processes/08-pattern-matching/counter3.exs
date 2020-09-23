defmodule Counter do
    def counter(counter \\ 0) do
        receive do
            {:inc, pid} -> 
              send(pid, counter + 1)
              counter( counter + 1)
            {:dec, pid} -> 
              send(pid, counter - 1)
              counter( counter - 1)
        end
    end
end

pid = spawn(&Counter.counter/0)

send(pid, {:inc, self()})
receive do
  answer -> IO.puts(answer)
end

send(pid, {:inc, self()})
receive do
  answer -> IO.puts(answer)
end

send(pid, {:dec, self()})
receive do
  answer -> IO.puts(answer)
end

send(pid, {:dec, self()})
receive do
  answer -> IO.puts(answer)
end

send(pid, {:inc, self()})
receive do
  answer -> IO.puts(answer)
end