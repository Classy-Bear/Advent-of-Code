defmodule DigitSpelledOut do
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

        if(DigitSpelledOut.can_be_number?(number)) do
          digit = DigitSpelledOut.as_number(number)

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
