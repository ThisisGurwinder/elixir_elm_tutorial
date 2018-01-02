defmodule Platform.Accounts do
  import Ecto.Query, warn: false
  alias Platform.Repo

  alias Platform.Accounts.Player
  def list_players do
    Repo.all(Player)
  end

  def get_player!(id), do: Repo.get!(Player, id)

  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  def change_player(%Player{} = player) do
    Player.changeset(player, %{})
  end
end
