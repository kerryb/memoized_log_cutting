defmodule MemoizedLogCutting do
  def cut_log(_prices, 0), do: 0

  def cut_log(prices, length) do
    Enum.reduce(1..length, 0, fn cut_length, max_price ->
      max(max_price, prices[cut_length] + cut_log(prices, length - cut_length))
    end)
  end
end
