defmodule Receive do
    def print() do
        receive do
            message -> IO.puts(message)
        end
        print()
    end
end

pid = spawn(&Receive.print/0)
send(pid, "hello")
send(pid, "hello")
:timer.sleep(1000)