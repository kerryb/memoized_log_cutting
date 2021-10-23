defmodule MemoizedLogCutting do
  def cut_log(prices, length), do: do_cut_log(prices, length, %{})

  defp do_cut_log(_prices, 0, _memo), do: 0

  defp do_cut_log(prices, length, memo) do
    Map.get_lazy(memo, length, fn ->
      {price, _memo} =
        Enum.reduce(1..length, {0, memo}, fn cut_length, {max_price, memo} ->
          cut_length_price = Map.get(prices, cut_length, 0)
          max_remainder_price = do_cut_log(prices, length - cut_length, memo)
          price = max(max_price, cut_length_price + max_remainder_price)
          {price, Map.put(memo, length, price)}
        end)

      price
    end)
  end
end
