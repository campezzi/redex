defmodule Redex.Repo.Migrations.CreateTodoItem do
  use Ecto.Migration

  def change do
    create table(:todo_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :todo_list_id, references(:todo_lists, type: :uuid)
      add :done, :boolean, default: false
      add :name, :string
      timestamps()
    end

  end
end
