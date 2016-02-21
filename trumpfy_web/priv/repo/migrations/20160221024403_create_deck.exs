defmodule TrumpfyWeb.Repo.Migrations.CreateDeck do
  use Ecto.Migration

  def change do
    create table(:decks) do
      add :name, :string
      add :attribute_name1, :string
      add :attribute_name2, :string
      add :attribute_name3, :string
      add :attribute_name4, :string

      timestamps
    end

  end
end
