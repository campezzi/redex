defmodule Redex.TodoItem do
  use Redex.Web, :model

  embedded_schema do
    field :name, :string
    field :done, :boolean, default: false
  end

  def complete(todo_item) do
    %{todo_item | done: true}
  end
end
