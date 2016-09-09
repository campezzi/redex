defmodule Redex.TodoList do
  use Redex.Web, :model

  @derive {Poison.Encoder, except: [:__meta__, :inserted_at, :updated_at]}

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "todo_lists" do
    field :name, :string
    has_many :items, TodoItem
    timestamps()
  end

  def new(id), do: %TodoList{id: id}

  def apply(todo_list, %TodoListCreated{} = event) do
    %{todo_list | name: event.name}
  end
end
