defmodule KittTest do
  use ExUnit.Case
  doctest Kitt

  test "greets the world" do
    assert Kitt.hello() == :world
  end
end
