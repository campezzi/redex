defmodule Redex.Router do
  use Redex.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Redex do
    pipe_through :api

    get "/demo", PageController, :demo

    get "/events", EventController, :index
    get "/events/snapshot", EventController, :snapshot

    get "/", ListController, :index
    post "/", ListController, :create
    post "/:todo_list_id/items", ListController, :add_item
    post "/:todo_list_id/items/:todo_item_id", ListController, :complete_item
  end
end
