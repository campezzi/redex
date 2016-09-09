defmodule Redex.ListController do
  use Redex.Web, :controller

  def index(conn, _params) do
    query = from l in TodoList, preload: :items
    json(conn, Repo.all(query))
  end

  def create(conn, params) do
    data = %TodoListCreated{name: params["name"]}
    id = create_event("TodoList", data)

    json(conn, %{result: "queued", todo_list_id: id})
  end

  def add_item(conn, params) do
    data = %TodoItemAdded{todo_list_id: params["todo_list_id"], name: params["name"]}
    id = create_event("TodoItem", data)

    json(conn, %{result: "queued", todo_item_id: id})
  end

  def complete_item(conn, params) do
    id = create_event("TodoItem", %TodoItemCompleted{}, params["todo_item_id"])

    json(conn, %{result: "queued", todo_item_id: id})
  end

  defp create_event(aggregate_type, data, aggregate_id \\ Ecto.UUID.generate) do
    Repo.insert!(Event.new(aggregate_type, aggregate_id, data))
    aggregate_id
  end
end
