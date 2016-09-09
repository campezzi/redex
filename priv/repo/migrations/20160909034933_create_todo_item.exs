defmodule Redex.Repo.Migrations.CreateTodoItem do
  use Ecto.Migration

  def change do
    create table(:todo_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      timestamps()
    end

  end
end
