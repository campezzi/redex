defmodule Redex.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :aggregate_type, :string, null: false
      add :aggregate_id, :uuid, null: false
      add :event_type, :string, null: false
      add :data, :map
      timestamps()
    end

  end
end
