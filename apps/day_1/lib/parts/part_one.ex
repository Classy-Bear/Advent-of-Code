defmodule PartOne do
  def run(file) do
    File.stream!(file)
    |> Enum.to_list()
    |> get_calibration_value()
    |> IO.puts()
  end

  defp get_calibration_value(calibration_values, b \\ 0)

  defp get_calibration_value([value | values], initial_value) do
    chars = String.graphemes(value)
    first_digit = Enum.find(chars, 0, &(&1 =~ ~r/[0-9]/))
    last_digit = Enum.find(Enum.reverse(chars), 0, &(&1 =~ ~r/[0-9]/))
    two_digit_number = String.to_integer(first_digit <> last_digit)
    sum = two_digit_number + initial_value
    get_calibration_value(values, sum)
  end

  defp get_calibration_value([], accumulator) do
    accumulator
  end
end
