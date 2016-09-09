defmodule Redex.TodoListTest do
  use Redex.ModelCase

  alias Redex.{TodoList, TodoItem, TodoListCreated, TodoItemAdded, TodoItemCompleted}

  describe "applying events" do
    setup do
      context = %{todo_list: TodoList.new("test-list")}

      {:ok, context}
    end

    test "TodoListCreated event sets the list name", context do
      event = %TodoListCreated{name: "Test List"}

      todo_list = TodoList.apply(context.todo_list, event)

      assert todo_list.name == "Test List"
    end

    test "TodoItemAdded adds an item to the todo list", context do
      event = fn id, name -> %TodoItemAdded{id: id, name: name} end

      todo_list =
        context.todo_list
        |> TodoList.apply(event.(1, "Test Item"))
        |> TodoList.apply(event.(2, "Another Item"))

      assert todo_list.items == [
        %TodoItem{id: 2, name: "Another Item"},
        %TodoItem{id: 1, name: "Test Item"}
      ]
    end

    test "TodoItemCompleted marks an item as done", context do
      event = %TodoItemCompleted{id: 1}
      todo_list = %{context.todo_list | items: [%TodoItem{id: 1, name: "Test Item"}]}

      todo_list = TodoList.apply(todo_list, event)
      todo_item = List.first(todo_list.items)

      assert todo_item.done?

      IO.inspect todo_list
    end
  end
end
