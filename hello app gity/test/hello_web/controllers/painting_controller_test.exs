defmodule HelloWeb.PaintingControllerTest do
  use HelloWeb.ConnCase

  import Hello.BaseballFixtures

  @create_attrs %{name: "some name", dataarray: "some dataarray"}
  @update_attrs %{name: "some updated name", dataarray: "some updated dataarray"}
  @invalid_attrs %{name: nil, dataarray: nil}

  describe "index" do
    test "lists all paintings", %{conn: conn} do
      conn = get(conn, ~p"/paintings")
      assert html_response(conn, 200) =~ "Listing Paintings"
    end
  end

  describe "new painting" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/paintings/new")
      assert html_response(conn, 200) =~ "New Painting"
    end
  end

  describe "create painting" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/paintings", painting: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/paintings/#{id}"

      conn = get(conn, ~p"/paintings/#{id}")
      assert html_response(conn, 200) =~ "Painting #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/paintings", painting: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Painting"
    end
  end

  describe "edit painting" do
    setup [:create_painting]

    test "renders form for editing chosen painting", %{conn: conn, painting: painting} do
      conn = get(conn, ~p"/paintings/#{painting}/edit")
      assert html_response(conn, 200) =~ "Edit Painting"
    end
  end

  describe "update painting" do
    setup [:create_painting]

    test "redirects when data is valid", %{conn: conn, painting: painting} do
      conn = put(conn, ~p"/paintings/#{painting}", painting: @update_attrs)
      assert redirected_to(conn) == ~p"/paintings/#{painting}"

      conn = get(conn, ~p"/paintings/#{painting}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, painting: painting} do
      conn = put(conn, ~p"/paintings/#{painting}", painting: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Painting"
    end
  end

  describe "delete painting" do
    setup [:create_painting]

    test "deletes chosen painting", %{conn: conn, painting: painting} do
      conn = delete(conn, ~p"/paintings/#{painting}")
      assert redirected_to(conn) == ~p"/paintings"

      assert_error_sent 404, fn ->
        get(conn, ~p"/paintings/#{painting}")
      end
    end
  end

  defp create_painting(_) do
    painting = painting_fixture()
    %{painting: painting}
  end
end
