defmodule TemporaryTest do
  use ExUnit.Case
  doctest Temporary

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "the add function takes two integers and add them together" do
   result = Temporary.add(1, 1)
   assert result == 2
   assert is_number(result)
  end
end
