defmodule Hello.BaseballFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Baseball` context.
  """

  @doc """
  Generate a painting.
  """
  def painting_fixture(attrs \\ %{}) do
    {:ok, painting} =
      attrs
      |> Enum.into(%{
        dataarray: "some dataarray",
        name: "some name"
      })
      |> Hello.Baseball.create_painting()

    painting
  end
end
