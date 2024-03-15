defmodule PartTwo do
  def run(file) do
    File.stream!(file)
    |> Enum.to_list()
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(&Enum.at(&1, 1))
    |> Enum.map(&get_cubes(&1))
    |> Enum.map(&get_max_cube_color(&1))
    |> Enum.map(&get_cube_power(&1))
    |> Enum.sum()
  end

  defp get_cube_power(max_cubes) do
    max_cubes[:red] * max_cubes[:green] * max_cubes[:blue]
  end

  defp get_cubes(random_cubes) do
    String.split(random_cubes, ";")
    |> Enum.flat_map(&String.split(&1, ","))
    |> Enum.map(&String.trim(&1))
    |> Enum.map(&String.split(&1, " "))
  end

  defp get_max_cube_color(
         hand,
         bigger_hand \\ %{
           red: 0,
           blue: 0,
           green: 0
         }
       )

  defp get_max_cube_color([], bigger_hand), do: bigger_hand

  defp get_max_cube_color(game, bigger_hand) do
    [hand | rest] = game
    cube_amount = Enum.at(hand, 0)
    cube_amount = String.to_integer(cube_amount)
    cube_color = Enum.at(hand, 1)

    case cube_color do
      "red" ->
        if bigger_hand[:red] < cube_amount do
          get_max_cube_color(rest, Map.put(bigger_hand, :red, cube_amount))
        else
          get_max_cube_color(rest, bigger_hand)
        end

      "green" ->
        if bigger_hand[:green] < cube_amount do
          get_max_cube_color(rest, Map.put(bigger_hand, :green, cube_amount))
        else
          get_max_cube_color(rest, bigger_hand)
        end

      "blue" ->
        if bigger_hand[:blue] < cube_amount do
          get_max_cube_color(rest, Map.put(bigger_hand, :blue, cube_amount))
        else
          get_max_cube_color(rest, bigger_hand)
        end
    end
  end
end
