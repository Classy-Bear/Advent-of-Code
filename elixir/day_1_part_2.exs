defmodule NumberSpelledOut do
  def as_number(_value = "one"), do: "1"
  def as_number(_value = "two"), do: "2"
  def as_number(_value = "three"), do: "3"
  def as_number(_value = "four"), do: "4"
  def as_number(_value = "five"), do: "5"
  def as_number(_value = "six"), do: "6"
  def as_number(_value = "seven"), do: "7"
  def as_number(_value = "eight"), do: "8"
  def as_number(_value = "nine"), do: "9"
  def as_number(_value), do: nil

  def can_be_number?(value) when is_binary(value) do
    cond do
      String.match?(value, ~r/^o(n(e)?)?$/) ->
        true

      String.match?(value, ~r/^t(w(o)?)?$/) ->
        true

      String.match?(value, ~r/^t(h(r(e(e)?)?)?)?$/) ->
        true

      String.match?(value, ~r/^f(o(u(r)?)?)?$/) ->
        true

      String.match?(value, ~r/^f(i(v(e)?)?)?$/) ->
        true

      String.match?(value, ~r/^s(i(x)?)?$/) ->
        true

      String.match?(value, ~r/^s(e(v(e(n)?)?)?)?$/) ->
        true

      String.match?(value, ~r/^e(i(g(h(t)?)?)?)?$/) ->
        true

      String.match?(value, ~r/^n(i(n(e)?)?)?$/) ->
        true

      true ->
        false
    end
  end
end

defmodule Calculator do
  def get_digit(chars, add_number, temp \\ "") do
    cond do
      Enum.empty?(chars) ->
        nil

      is_number?(Enum.at(chars, 0)) ->
        [head | tail] = chars
        add_number.(head)
        get_digit(tail, add_number, temp)

      true ->
        [head | tail] = chars
        number = temp <> head

        if(NumberSpelledOut.can_be_number?(number)) do
          digit = NumberSpelledOut.as_number(number)

          if digit do
            add_number.(digit)
            get_digit(tail, add_number, head)
          else
            get_digit(tail, add_number, number)
          end
        else
          [_ | temp] = String.graphemes(number)
          get_digit(tail, add_number, Enum.join(temp))
        end
    end
  end

  def is_number?(value) do
    value =~ ~r/[0-9]/
  end
end

defmodule Machine do
  def compute(word) do
    chars = String.graphemes(word)
    {:ok, numbers} = Agent.start_link(fn -> [] end)

    Calculator.get_digit(chars, fn number ->
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

defmodule Main do
  def run do
    File.stream!("./AdventCode/day_1/calibration_document_part_two.txt")
    |> Enum.to_list()
    |> Enum.map(&Machine.compute(&1))
    |> Enum.sum()
    |> IO.puts()
  end
end

Main.run()
