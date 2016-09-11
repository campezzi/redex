defmodule Redex.TodoItemCompleted do
  defstruct []

  def from_data(data) do
    Enum.reduce(data, %__MODULE__{}, fn {k,v}, acc ->
      Map.put(acc, String.to_existing_atom(k), v)
    end)
  end
end
