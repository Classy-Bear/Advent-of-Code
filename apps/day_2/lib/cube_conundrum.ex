defmodule CubeConundrum do
  def run(file) do
    File.stream!(file)
    |> Enum.to_list()
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(&Enum.at(&1, 1))
    |> Enum.map(&get_cubes(&1))
    |> Enum.map(&is_game_valid?(&1))
    |> Enum.with_index(1)
    |> sum_games()
  end

  defp sum_games(list, count \\ 0)

  defp sum_games([], count), do: count

  defp sum_games([head | tail], count) do
    if elem(head, 0) do
      sum_games(tail, count + elem(head, 1))
    else
      sum_games(tail, count)
    end
  end

  defp is_game_valid?([]), do: true

  defp is_game_valid?(game) do
    [head | tail] = game
    if(is_grab_ok?(head)) do
      is_game_valid?(tail)
    else
      false
    end
  end

  defp get_cubes(random_cubes) do
    String.split(random_cubes, ";")
    |> Enum.flat_map(&String.split(&1, ","))
    |> Enum.map(&String.trim(&1))
    |> Enum.map(&String.split(&1, " "))
  end

  defp is_grab_ok?(hand) do
    cube_amount = Enum.at(hand, 0)
    cube_amount = String.to_integer(cube_amount)
    cube_color = Enum.at(hand, 1)
    desired_cubes = %{red: 12, green: 13, blue: 14}

    case cube_color do
      "red" -> cube_amount <= desired_cubes[:red]
      "green" -> cube_amount <= desired_cubes[:green]
      "blue" -> cube_amount <= desired_cubes[:blue]
    end
  end
end
