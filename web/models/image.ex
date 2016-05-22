defmodule HelloPhoenix.Image do
  use HelloPhoenix.Web, :model

  schema "images" do
    field :path, :string
    belongs_to :product, HelloPhoenix.Product

    timestamps
  end

  @required_fields ~w(product_id)
  @optional_fields ~w(path)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
