defmodule PRM.Web.DivisionView do
  @moduledoc false

  use PRM.Web, :view
  alias PRM.Web.DivisionView

  def render("index.json", %{divisions: divisions}) do
    render_many(divisions, DivisionView, "division.json")
  end

  def render("show.json", %{division: division}) do
    render_one(division, DivisionView, "division.json")
  end

  def render("division.json", %{division: division}) do
    %{
      id: division.id,
      name: division.name,
      type: division.type,
      mountain_group: division.mountain_group,
      addresses: division.addresses,
      phones: division.phones,
      email: division.email,
      external_id: division.external_id,
      legal_entity_id: division.legal_entity_id,
      status: division.status,
      location: to_coordinates(division.location)
    }
  end

  def to_coordinates(%Geo.Point{coordinates: {lng, lat}}) do
    %{
      longitude: lng,
      latitude: lat,
    }
  end

  def to_coordinates(field), do: field
end
