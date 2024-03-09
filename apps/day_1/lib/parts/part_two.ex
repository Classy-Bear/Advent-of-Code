defmodule PartTwo do
  def run(file) do
    File.stream!(file)
    |> Enum.to_list()
    |> Enum.map(&compute(&1))
    |> Enum.sum()
    |> IO.puts()
  end

  defp compute(word) do
    chars = String.graphemes(word)
    {:ok, numbers} = Agent.start_link(fn -> [] end)

    DigitSpelledOut.get_digit(chars, fn number ->
      Agent.update(numbers, &[number | &1])
    end)

    numbers_found = Agent.get(numbers, & &1)
    numbers_found = Enum.reverse(numbers_found)
    first_digit = Enum.at(numbers_found, 0)
    [_ | tail] = numbers_found
    last_digit = Enum.at(tail, length(tail) - 1)

    # Uncomment this to see results
    # IO.puts("#{word} Head -> #{first_digit} Tail -> #{last_digit}")

    Agent.stop(numbers)

    cond do
      first_digit == nil ->
        0

      last_digit == nil ->
        String.to_integer(first_digit <> first_digit)

      true ->
        String.to_integer(first_digit <> last_digit)
    end
  end
end
