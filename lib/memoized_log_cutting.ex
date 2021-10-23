defmodule MemoizedLogCutting do
  def cut_log(_prices, 0), do: 0

  def cut_log(prices, length) do
    Enum.reduce(1..length, 0, fn cut_length, max_price ->
      max(max_price, Map.get(prices, cut_length, 0) + cut_log(prices, length - cut_length))
    end)
  end
end
