defmodule Hello.Repo.Migrations.CreatePaintings do
  use Ecto.Migration

  def change do
    create table(:paintings) do
      add :name, :string
      add :dataarray, :text

      timestamps(type: :utc_datetime)
    end
  end
end
