defmodule TrumpfyWeb.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :name, :string
      add :image_url, :string
      add :attribute1, :integer
      add :attribute2, :integer
      add :attribute3, :integer
      add :attribute4, :integer
      add :deck_id, references(:decks)

      timestamps
    end
    create index(:cards, [:deck_id])

  end
end
