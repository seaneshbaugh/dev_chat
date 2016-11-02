defmodule DevChat.Room do
  use DevChat.Web, :model

  schema "rooms" do
    field :name, :string, default: ""
    field :slug, :string, default: ""

    timestamps
  end

  def changeset(model, action, params \\ :empty)

  def changeset(model, :new, _params) do
    model
    |> cast(:empty, ~w(), ~w())
  end

  def changeset(model, action, params) do
    model
    |> cast(params, ~w(name))
    |> set_slug
    |> validate_length(:name, min: 4)
    |> validate_length(:name, max: 64)
  end

  defp set_slug(changeset) do
    name = Ecto.Changeset.get_field(changeset, :name) || ""

    slug = name
    |> String.replace(~r/[^a-zA-Z0-9]/, "-")
    |> String.replace(~r/-+/, "-")
    |> String.replace(~r/(\A-)|(\z-)/, "")
    |> String.downcase

    Ecto.Changeset.put_change(changeset, :slug, slug)
  end
end
