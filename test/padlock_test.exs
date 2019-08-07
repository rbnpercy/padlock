defmodule PadlockTest do
  use ExUnit.Case
  doctest Padlock

  test "greets the world" do
    assert Padlock.hello() == :world
  end
end
