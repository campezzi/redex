defmodule Redex.Repo.Migrations.CreateTodoList do
  use Ecto.Migration

  def change do
    create table(:todo_lists, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :items, {:array, :map}, default: []
      timestamps()
    end
  end
end
