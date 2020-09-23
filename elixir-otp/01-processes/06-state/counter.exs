defmodule Counter do
    def counter(parent_id, counter \\ 0) do
        receive do
            _ -> send(parent_id, counter) # need some variable "current"
        end

        counter(parent_id, counter + 1)
    end
end

parent_pid = self()
counter_pid = spawn( fn -> Counter.counter(parent_pid) end)

# Ask for next number by sending it a dummy message
send(counter_pid, nil)

# Receive the answer
receive do
    n -> IO.puts(n) # Should print 0
end

# Rinse and repeat
send(counter_pid, nil)
receive do
    n -> IO.puts(n) # Should print 1
end

send(counter_pid, nil)
receive do
    n -> IO.puts(n) # Should print 2
end