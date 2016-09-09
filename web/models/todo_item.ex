defmodule Redex.TodoItem do
  use Redex.Web, :model

  @derive {
    Poison.Encoder,
    except: [
      :__meta__,
      :inserted_at,
      :updated_at,
      :todo_list,
      :todo_list_id
    ]
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "todo_items" do
    field :name, :string
    field :done, :boolean, default: false

    belongs_to :todo_list, TodoList

    timestamps()
  end

  def new(id), do: %TodoItem{id: id}

  def complete(todo_item) do
    %{todo_item | done: true}
  end

  def apply(todo_item, %TodoItemAdded{} = event) do
    %{todo_item | name: event.name, todo_list_id: event.todo_list_id}
  end

  def apply(todo_item, %TodoItemCompleted{}) do
    %{todo_item | done: true}
  end

end
