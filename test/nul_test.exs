defmodule NulTest do
  use ExUnit.Case
  doctest Nul

  test "greets the world" do
    assert Nul.hello() == :world
  end
end
