defmodule Redex.TodoList do
  use Redex.Web, :model

  @derive {Poison.Encoder, except: [:__meta__, :inserted_at, :updated_at]}

  schema "todo_lists" do
    field :name, :string
    has_many :items, TodoItem
    timestamps()
  end

  def new(id), do: %TodoList{id: id}

  def apply(todo_list, %TodoListCreated{} = event) do
    %TodoList{ todo_list | name: event.name }
  end
end
