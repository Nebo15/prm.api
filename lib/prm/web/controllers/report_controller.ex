defmodule PRM.Web.ReportController do
  @moduledoc false

  use PRM.Web, :controller

  alias PRM.Declaration.Report

  def declarations(conn, params) do
    with {:ok, declarations} <- Report.report(params) do
      render(conn, "declarations_report.json", declarations: declarations)
    end
  end
end
