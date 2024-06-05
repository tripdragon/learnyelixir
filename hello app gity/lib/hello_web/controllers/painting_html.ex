defmodule HelloWeb.PaintingHTML do
  use HelloWeb, :html

  embed_templates "painting_html/*"

  @doc """
  Renders a painting form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def painting_form(assigns)
end
