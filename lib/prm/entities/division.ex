defmodule PRM.Entities.Division do
  @moduledoc false

  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "divisions" do
    field :email, :string
    field :external_id, :string
    field :mountain_group, :string
    field :name, :string
    field :addresses, {:array, :map}
    field :phones, {:array, :map}
    field :type, :string

    belongs_to :legal_entity, PRM.Entities.LegalEntity, type: Ecto.UUID

    timestamps()
  end
end
