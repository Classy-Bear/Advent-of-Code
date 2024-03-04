defmodule Trebuchet do
  def get_calibration_value(calibration_values, b \\ 0)

  def get_calibration_value([value | values], initial_value) do
    chars = String.graphemes(value)
    first_digit = Enum.find(chars, 0, &(&1 =~ ~r/[0-9]/))
    last_digit = Enum.find(Enum.reverse(chars), 0, &(&1 =~ ~r/[0-9]/))
    sum = String.to_integer(first_digit <> last_digit) + initial_value
    get_calibration_value(values, sum)
  end

  def get_calibration_value([], accumulator) do
    accumulator
  end
end

File.stream!("./input.txt") |> Enum.to_list |> Trebuchet.get_calibration_value |> IO.puts
