defmodule Redex.ListController do
  use Redex.Web, :controller
  alias Redex.{TodoList, TodoItem, TodoListCreated, TodoItemAdded, TodoItemCompleted}

  def demo(conn, _params) do

    # create the todo list
    todo_list =
      Ecto.UUID.generate
      |> TodoList.new
      |> TodoList.apply(%TodoListCreated{name: "To Read"})

    Repo.insert!(todo_list)

    # create todo items
    elixir_in_action =
      Ecto.UUID.generate
      |> TodoItem.new
      |> TodoItem.apply(%TodoItemAdded{todo_list_id: todo_list.id, name: "Elixir in Action"})

    grokking_algorithms =
      Ecto.UUID.generate
      |> TodoItem.new
      |> TodoItem.apply(%TodoItemAdded{todo_list_id: todo_list.id, name: "Grokking Algorithms"})
      |> TodoItem.apply(%TodoItemCompleted{})

    learn_you_a_haskell =
      Ecto.UUID.generate
      |> TodoItem.new
      |> TodoItem.apply(%TodoItemAdded{todo_list_id: todo_list.id, name: "Learn You a Haskell"})

    [elixir_in_action, grokking_algorithms, learn_you_a_haskell]
    |> Enum.map(fn item -> Repo.insert!(item) end)

    # render output
    todo_list = Repo.preload(todo_list, :items)
    json(conn, todo_list)
  end
end
