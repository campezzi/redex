defmodule Redex.TodoListTest do
  use Redex.ModelCase

  alias Redex.{TodoList, TodoListCreated}

  describe "applying events" do
    setup do
      context = %{todo_list: TodoList.new("test-list")}

      {:ok, context}
    end

    test "TodoListCreated event sets the list name", %{todo_list: todo_list} do
      event = %TodoListCreated{name: "Test List"}

      todo_list = TodoList.apply(todo_list, event)

      assert todo_list.name == "Test List"
    end
  end
end
