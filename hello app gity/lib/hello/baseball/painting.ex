defmodule Hello.Baseball.Painting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "paintings" do
    field :name, :string
    field :dataarray, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(painting, attrs) do
    painting
    |> cast(attrs, [:name, :dataarray])
    |> validate_required([:name, :dataarray])
  end
  
end

defmodule HelloWeb.PaintingJSONEncoder do
  defimpl Jason.Encoder, for: Hello.Baseball.Painting do
    def encode(%Hello.Baseball.Painting{} = painting, opts) do
      Jason.Encode.map(Map.take(painting, [:id, :name, :dataarray]), opts)
    end
  end
end
