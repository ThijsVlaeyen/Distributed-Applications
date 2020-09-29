Task.async(fn -> :ok1 end)
Task.async(fn -> :ok2 end)
Task.async(fn -> :ok3 end)

#Helemaal niet gestolen kekw
defmodule Receive do
  def message() do
    receive do
      {ref, val} ->
        IO.puts("I've received #{inspect(val)} form #{inspect(ref)}")

      {:DOWN, ref, :process, pid, :normal} ->
        IO.puts("Normal process exit form #{inspect(pid)} with ref #{inspect(ref)}")
    end

    message()
  end
end

Receive.message()