defmodule Redex.EventController do
  use Redex.Web, :controller
  alias Redex.Event

  def index(conn, _params) do
    json(conn, all_events)
  end

  def reset_snapshot(conn, _params) do
    clear_snapshot
    json(conn, %{result: "ok"})
  end

  def snapshot(conn, _params) do
    clear_snapshot

    events = all_events

    aggregates =
      Enum.reduce(events, %{}, fn event, aggregates ->
        event_struct = apply(event_module(event), :from_data, [event.data])
        aggregate = Map.get_lazy(aggregates, event.aggregate_id, fn -> init_aggregate(event) end)
        aggregate = apply(aggregate_module(event), :apply, [aggregate, event_struct])
        Map.put(aggregates, event.aggregate_id, aggregate)
      end)

    events
    |> Stream.map(fn event -> event.aggregate_id end)
    |> Stream.uniq
    |> Enum.each(fn aggregate_id -> Repo.insert!(aggregates[aggregate_id]) end)

    json(conn, %{result: "ok"})
  end

  defp clear_snapshot do
    Repo.delete_all(TodoItem)
    Repo.delete_all(TodoList)
  end

  defp all_events do
    Repo.all(Event.ordered_by_id)
  end

  defp init_aggregate(event) do
    apply(aggregate_module(event), :new, [event.aggregate_id])
  end

  defp aggregate_module(event) do
    String.to_existing_atom("Elixir.Redex.#{event.aggregate_type}")
  end

  defp event_module(event) do
    String.to_existing_atom("Elixir.Redex.#{event.event_type}")
  end
end
