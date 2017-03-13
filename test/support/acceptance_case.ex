defmodule PRM.Support.AcceptanceCase do
  @moduledoc """
  Acceptance test helper
  """
  use ExUnit.CaseTemplate

  using do
    repo =
      case System.get_env("CONTAINER_HTTP_PORT") do
        nil -> PRM.Repo
        _   -> nil
      end

    quote do
      use EView.AcceptanceCase,
        async: false,
        otp_app: :prm,
        endpoint: PRM.Web.Endpoint,
        repo: unquote(repo),
        headers: [{"content-type", "application/json"}]

      def assert_error(%HTTPoison.Response{body: %{} = body} = response, code, entry, type) do
        assert %{
          "meta" => %{"code" => ^code},
          "error" => %{
            "message" => _,
            "type" => "validation_failed",
            "invalid" => [%{
              "entry" => ^entry,
              "entry_type" => ^type,
              "rules" => ["required"]
            }]
          },
        } = body

        response
       end

      def assert_404(%HTTPoison.Response{body: %{} = body} = response) do
        assert %{
          "meta" => %{
            "code" => 404,
            "request_id" => _,
            "type" => "object",
            "url" => _
          },
          "error" => %{
            "type" => "not_found"
          }
        } = body

        response
       end

      def assert_422(%HTTPoison.Response{body: %{} = body} = response) do
        assert %{
          "meta" => %{
            "code" => 422,
            "request_id" => _,
            "type" => "object",
            "url" => _
          },
          "error" => %{
            "invalid" => _,
            "message" => _,
            "type" => "validation_failed"
          }
        } = body
        response
       end

      def assert_status(%HTTPoison.Response{status_code: status_code} = response, status) do
        assert status == status_code
        response
      end

    end
  end
end
