defmodule Redex.Event do
  use Redex.Web, :model

  schema "events" do
    field :aggregate_type, :string
    field :aggregate_id, Ecto.UUID
    field :data, :map

    timestamps()
  end
end
