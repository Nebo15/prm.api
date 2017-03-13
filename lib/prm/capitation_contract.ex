defmodule Prm.CapitationContract do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "capitation_contracts" do
    field :start_date, :utc_datetime
    field :end_date, :utc_datetime
    field :status, :string
    field :signed_at, :utc_datetime
    field :services, {:array, :map}

    belongs_to :product, Prm.Product, type: Ecto.UUID
    belongs_to :msp, Prm.MSP, type: Ecto.UUID

    timestamps(type: :utc_datetime)
  end
end