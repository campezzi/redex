defmodule Redex.TodoItemTest do
  use Redex.ModelCase

  alias Redex.{TodoItem, TodoItemAdded, TodoItemCompleted}

  setup do
    context = %{todo_item: TodoItem.new("test-item")}

    {:ok, context}
  end

  test "TodoItemAdded sets the name and todo list references", %{todo_item: todo_item} do
    event = %TodoItemAdded{todo_list_id: "test-list", name: "Test Item"}

    todo_item = TodoItem.apply(todo_item, event)

    assert todo_item.name == "Test Item"
    assert todo_item.todo_list_id == "test-list"
  end

  test "TodoItemCompleted sets done to true", %{todo_item: todo_item} do
    event = %TodoItemCompleted{}

    todo_item = TodoItem.apply(todo_item, event)

    assert todo_item.done == true
  end
end
