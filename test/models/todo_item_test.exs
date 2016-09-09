defmodule Redex.TodoItemTest do
  use Redex.ModelCase

  alias Redex.TodoItem

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TodoItem.changeset(%TodoItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TodoItem.changeset(%TodoItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
