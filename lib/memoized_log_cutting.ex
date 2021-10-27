defmodule MemoizedLogCutting do
  def cut_log(prices, length) do
    {value, _} = do_cut_log(prices, length, %{0 => 0})
    value
  end

  def do_cut_log(prices, length, memo) do
    case memo[length] do
      nil -> calculate_max_value(prices, length, memo)
      value -> {value, memo}
    end
  end

  defp calculate_max_value(prices, length, memo) do
    Enum.reduce(1..length, {0, memo}, fn cut_length, {max_value, memo} ->
      cut_value = Map.get(prices, cut_length, 0)
      {remainder_value, memo} = do_cut_log(prices, length - cut_length, memo)
      value = max(max_value, cut_value + remainder_value)
      {value, Map.put(memo, length, value)}
    end)
  end
end
