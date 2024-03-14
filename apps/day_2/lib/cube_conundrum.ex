defmodule CubeConundrum do
  def run(file) do
    File.stream!(file)
    |> Enum.to_list()
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(&Enum.at(&1, 1))
    |> Enum.map(&get_cubes(&1))
    |> Enum.map(&is_game_valid(&1))
    |> Enum.with_index(1)
    |> Enum.filter(fn {k, v} -> k == true end)
    |> Enum.map(fn {k, v} -> v end)
    |> Enum.sum()
  end

  defp is_game_valid([]) do
    true
  end

  defp is_game_valid(game) do
    [head | tail] = game
    if(is_grab_ok?(head)) do
      is_game_valid(tail)
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
