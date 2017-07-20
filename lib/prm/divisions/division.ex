defmodule PRM.Divisions.Division do
  @moduledoc false

  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "divisions" do
    field :email, :string
    field :external_id, :string
    field :mountain_group, :boolean
    field :name, :string
    field :addresses, {:array, :map}
    field :phones, {:array, :map}
    field :type, :string
    field :status, :string, null: false
    field :is_active, :boolean, default: false
    field :location, Geo.Geometry

    belongs_to :legal_entity, PRM.Entities.LegalEntity, type: Ecto.UUID

    timestamps()
  end
end
