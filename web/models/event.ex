defmodule Redex.Event do
  use Redex.Web, :model

  @derive {Poison.Encoder, except: [:__meta__, :inserted_at, :updated_at]}
  schema "events" do
    field :aggregate_type, :string
    field :aggregate_id, Ecto.UUID
    field :event_type, :string
    field :data, :map

    timestamps()
  end

  def new(aggregate_type, aggregate_id, data) do
    %Event{
      aggregate_type: aggregate_type,
      aggregate_id: aggregate_id,
      event_type: event_type_from_struct(data),
      data: Map.from_struct(data)
    }
  end

  defp event_type_from_struct(data) do
    data
    |> Map.fetch!(:__struct__)
    |> to_string
    |> String.split(".")
    |> List.last
  end

  def ordered_by_id do
    from e in Event, order_by: e.id
  end

  def process(event) do
    event_module = :"Elixir.Redex.#{event.event_type}"
    apply(event_module, :aggregate_from_event, [event])
  end
end
