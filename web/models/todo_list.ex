defmodule Redex.TodoList do
  use Redex.Web, :model
  alias Redex.{TodoList, TodoItem, TodoListCreated, TodoItemAdded, TodoItemCompleted}

  schema "todo_lists" do
    field :name, :string
    embeds_many :items, TodoItem
    timestamps()
  end

  def new(id), do: %TodoList{id: id}

  def apply(todo_list, %TodoListCreated{} = event) do
    %TodoList{ todo_list | name: event.name }
  end
  def apply(todo_list, %TodoItemAdded{} = event) do
    item = %TodoItem{id: event.id, name: event.name}
    %TodoList{ todo_list | items: [item | todo_list.items] }
  end
  def apply(todo_list, %TodoItemCompleted{} = event) do
    event_item_id = event.id

    complete_item = fn item ->
      case item.id do
        ^event_item_id -> TodoItem.complete(item)
        _ -> item
      end
    end

    new_items =
      todo_list.items
      |> Enum.map(complete_item)

    %TodoList{todo_list | items: new_items}
  end
end
