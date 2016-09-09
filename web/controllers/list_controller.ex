defmodule Redex.ListController do
  use Redex.Web, :controller
  alias Redex.{TodoList, TodoListCreated, TodoItemAdded, TodoItemCompleted}

  def demo(conn, _params) do
    todo_list = TodoList.new(Ecto.UUID.generate)

    events = [
      %TodoListCreated{name: "To Read"},
      %TodoItemAdded{id: 1, name: "Elixir in Action"},
      %TodoItemAdded{id: 2, name: "Grokking Algorithms"},
      %TodoItemAdded{id: 3, name: "Grokking Machine Learning"},
      %TodoItemCompleted{id: 3}
    ]

    todo_list = Enum.reduce(events, todo_list, fn event, acc -> TodoList.apply(acc, event) end)

    case Repo.insert(todo_list) do
      {:ok, todo_list} -> json(conn, todo_list)
      {:error, message} -> json(conn, message)
    end
  end
end
