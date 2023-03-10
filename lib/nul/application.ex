defmodule Nul.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Kino.SmartCell.register(Nul.SmartCell)
    children = []

    opts = [strategy: :one_for_one, name: Nul.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
