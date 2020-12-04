defmodule Bypass.Supervisor do
  @moduledoc false

  if Code.ensure_loaded?(DynamicSupervisor) do
    def start_link() do
      opts = [strategy: :one_for_one, name: Bypass.Supervisor]
      DynamicSupervisor.start_link(opts)
    end

    def start_child(opts) do
      DynamicSupervisor.start_child(Bypass.Supervisor, Bypass.Instance.child_spec(opts))
    end
  else
    def start_link() do
      import Supervisor.Spec, warn: false

      children = [
        worker(Bypass.Instance, [], restart: :transient)
      ]

      opts = [strategy: :simple_one_for_one, name: Bypass.Supervisor]
      Supervisor.start_link(children, opts)
    end

    def start_child(opts) do
      Supervisor.start_child(Bypass.Supervisor, [opts])
    end
  end
end
