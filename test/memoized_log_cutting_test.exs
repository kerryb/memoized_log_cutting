defmodule MemoizedLogCuttingTest do
  use ExUnit.Case

  describe "MemoizedLogCutting.cut_log/1" do
    @p %{0 => 0, 1 => 1, 2 => 5, 3 => 8, 4 => 9, 5 => 10}

    test "returns the expected value for simple case" do
      assert MemoizedLogCutting.cut_log(@p, 1) == 1
    end

    test "returns the highest possible price when it corresponds to a single length" do
      assert MemoizedLogCutting.cut_log(@p, 2) == 5
    end

    test "returns the highest possible price when it requires multiple lengths" do
      assert MemoizedLogCutting.cut_log(@p, 5) == 13
    end

    test "works when the log is longer than the highest length in the price list" do
      assert MemoizedLogCutting.cut_log(@p, 10) == 26
    end

    test "returns the result for long logs in an acceptable amount of time" do
      Task.async(fn -> MemoizedLogCutting.cut_log(@p, 50) end)
      |> Task.await(:timer.seconds(1))
    end
  end
end
