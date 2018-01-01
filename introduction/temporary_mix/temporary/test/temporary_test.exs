defmodule TemporaryTest do
  use ExUnit.Case
  doctest Temporary

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "the add function takes two integers and add them together" do
   Temporary.add(1, 1)
   |> result == 2
   |> assert
  end
end
