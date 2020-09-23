defmodule Counter do
    def counter(counter \\ 0) do
        receive do
            pid -> send(pid, counter)
        end

        counter(counter + 1)
    end
end

pid = spawn(&Counter.counter/0)

send(pid, self())
receive do
  answer -> IO.puts(answer)
end

send(pid, self())
receive do
  answer -> IO.puts(answer)
end

send(pid, self())
receive do
  answer -> IO.puts(answer)
end

send(pid, self())
receive do
  answer -> IO.puts(answer)
end

send(pid, self())
receive do
  answer -> IO.puts(answer)
end