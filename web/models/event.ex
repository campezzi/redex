defmodule Redex.Event do
  use Redex.Web, :model

  schema "events" do
    field :aggregate_id, Ecto.UUID

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:aggregate_id])
    |> validate_required([:aggregate_id])
  end
end
