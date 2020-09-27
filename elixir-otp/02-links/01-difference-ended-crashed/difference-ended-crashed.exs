normalexit = fn ->
  :timer.sleep(5000)
  :finished
end

crashexit = fn ->
  :timer.sleep(5000)
  raise "ERROR"
end

mycurrentpid = inspect(self())
mycurrentpid

p1 = spawn(normalexit)
Process.link(p1)
p2 = spawn(crashexit)
Process.link(p2)

inspect(self())



normalexit = fn ->
  :timer.sleep(5000)
  :finished
end

crashexit = fn ->
  :timer.sleep(5000)
  raise "ERROR"
end

mycurrentpid = inspect(self())
mycurrentpid

p1 = spawn_link(normalexit)
p2 = spawn_link(crashexit)

inspect(self())
