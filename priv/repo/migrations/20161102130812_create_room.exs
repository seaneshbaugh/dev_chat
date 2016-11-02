defmodule DevChat.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string, null: false, default: ""
      add :slug, :string, null: false, default: ""

      timestamps
    end

    create index(:rooms, [:name], unique: true)
    create index(:rooms, [:slug], unique: true)
  end
end
