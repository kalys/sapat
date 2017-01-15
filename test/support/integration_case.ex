defmodule Sapat.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Sapat.ConnCase
      use PhoenixIntegration
    end
  end

end
