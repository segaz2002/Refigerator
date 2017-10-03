defmodule FridgeServer do
  @moduledoc false
  use GenServer

  def start_link(items) do
    {:ok, fridge} = GenServer.start_link FridgeServer, items, []
    fridge
  end

  def store(fridge, item) do
    GenServer.call(fridge, {:store, item})
  end

  def take(fridge, item) do
    GenServer.call(fridge, {:take, item})
  end

  def init(items) do
    {:ok, items}
  end

  def handle_call({:store, item}, _from, items) do
    {:reply, :ok, [item|items]}
  end

  def handle_call({:take, item}, _from, items) do
    case Enum.member?(items, item) do
      true -> {:reply, {:ok, item}, List.delete(items, item)}
      false -> {:reply, {:not_found}, items}
    end

  end


end
