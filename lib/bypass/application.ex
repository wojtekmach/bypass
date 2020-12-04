defmodule Bypass.Application do
  use Application

  def start(_type, _args) do
    Bypass.Supervisor.start_link()
  end
end
