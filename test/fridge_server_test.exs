defmodule FridgeServerTest do
  use ExUnit.Case

  setup do
    fridge = FridgeServer.start_link([]);
    {:ok, [fridge: fridge]}
  end

  test "putting something into the fridge", %{fridge: fridge} do
    assert :ok == FridgeServer.store(fridge, :bacon)
  end

  test "removing something from the fridge", %{fridge: fridge} do
    FridgeServer.store(fridge, :bacon)
    assert {:ok, :bacon} == FridgeServer.take(fridge, :bacon)
  end

  test "removing something from the fridge, that is not there", %{fridge: fridge} do
    assert {:not_found} == FridgeServer.take(fridge, :bacon)
  end
end