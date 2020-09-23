defmodule Receive do
    def print(parent_pid) do
        receive do
            message -> IO.puts(message)
            send(parent_pid, :success)
        end
        print(parent_pid)
    end
end

parent_pid = self()
pid = spawn(fn -> Receive.print(parent_pid) end)
send(pid, "hello")
send(pid, "hello")

receive do
  _ -> nil
end

receive do
  _ -> nil
end