defmodule Numbers do
  def odd?(x), do: rem(x, 2) != 0
  def even?(x), do: rem(x, 2) == 0
end