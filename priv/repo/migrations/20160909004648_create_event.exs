defmodule Redex.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :aggregate_id, :uuid, null: false
      add :data, :map
      timestamps()
    end

  end
end
