defmodule HelloWeb.PaintingController do
  use HelloWeb, :controller

  alias Hello.Baseball
  alias Hello.Baseball.Painting

  # import Ecto.Query, warn: false
  # alias Hello.Repo

  
  # ai modified, those are not working, so back to normal
  def index(conn, _params) do
    paintings = Baseball.list_paintings()
    render(conn, :index, paintings: paintings)
  end
  
  # ai added
  # def index(conn, _params) do
  #   paintings = Baseball.list_paintings()
  #   if get_req_header(conn, "x-requested-with") == ["XMLHttpRequest"] do
  #     json(conn, %{paintings: paintings})
  #   else
  #     render(conn, :index, paintings: paintings)
  #   end
  # end
  # def index(conn, _params) do
  #   paintings = Baseball.list_paintings()
  # 
  #   if get_req_header(conn, "x-requested-with") == ["XMLHttpRequest"] do
  #     conn
  #     |> put_resp_content_type("application/json")
  #     |> json(%{paintings: paintings})
  #   else
  #     render(conn, :index, paintings: paintings)
  #   end
  # end



  def new(conn, _params) do
    changeset = Baseball.change_painting(%Painting{})
    render(conn, :new, changeset: changeset)
  end
  
  # ai altered
  # def create(conn, %{"painting" => painting_params}) do
  #   case Baseball.create_painting(painting_params) do
  #     {:ok, painting} ->
  #       conn
  #       |> put_flash(:info, "Painting created successfully.")
  #       |> redirect(to: ~p"/paintings/#{painting}")
  # 
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :new, changeset: changeset)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    painting = Baseball.get_painting!(id)
    render(conn, :show, painting: painting)
  end

  def edit(conn, %{"id" => id}) do
    painting = Baseball.get_painting!(id)
    changeset = Baseball.change_painting(painting)
    render(conn, :edit, painting: painting, changeset: changeset)
  end

  def update(conn, %{"id" => id, "painting" => painting_params}) do
    painting = Baseball.get_painting!(id)

    case Baseball.update_painting(painting, painting_params) do
      {:ok, painting} ->
        conn
        |> put_flash(:info, "Painting updated successfully.")
        |> redirect(to: ~p"/paintings/#{painting}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, painting: painting, changeset: changeset)
    end
  end

  # def delete(conn, %{"id" => id}) do
  #   painting = Baseball.get_painting!(id)
  #   {:ok, _painting} = Baseball.delete_painting(painting)
  # 
  #   conn
  #   |> put_flash(:info, "Painting deleted successfully.")
  #   |> redirect(to: ~p"/paintings")
  # end
  def delete(conn, %{"id" => id}) do
    painting = Baseball.get_painting!(id)
    case painting do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Painting not found"})
      painting ->
        case Baseball.delete_painting(painting) do
          {:ok, _painting} ->
            conn
            #|> put_status(:ok)
            |> put_flash(:info, "Painting deleted successfully.")
            |> json(%{message: "Painting deleted successfully"})
          {:error, _reason} ->
            conn
            |> put_status(:internal_server_error)
            |> json(%{error: "Failed to delete painting"})
        end
    end
  end
  
  
  # AI added
  # def create(conn, %{"painting" => painting_params}) do
  #   case Baseball.create_painting(painting_params) do
  #     {:ok, painting} ->
  #       if get_req_header(conn, "x-requested-with") == ["XMLHttpRequest"] do
  #         conn
  #         |> put_status(:created)
  #         |> json(%{status: "ok", painting: painting})
  #       else
  #         conn
  #         |> put_flash(:info, "Painting created successfully.")
  #         |> redirect(to: ~p"/paintings/#{painting}")
  #       end
  # 
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       if get_req_header(conn, "x-requested-with") == ["XMLHttpRequest"] do
  #         conn
  #         |> put_status(:unprocessable_entity)
  #         |> json(%{status: "error", errors: changeset})
  #       else
  #         render(conn, :new, changeset: changeset)
  #       end
  #   end
  # end



  # 
  # def create(conn, %{"painting" => painting_params}) do
  #   case Baseball.create_painting(painting_params) do
  #     {:ok, painting} ->
  #       if get_req_header(conn, "x-requested-with") == ["XMLHttpRequest"] do
  #         conn
  #         |> put_resp_content_type("application/json")
  #         |> json(%{status: "ok", painting: painting})
  #       else
  #         conn
  #         |> put_flash(:info, "Painting created successfully.")
  #         |> redirect(to: ~p"/paintings/#{painting}")
  #         # |> redirect(to: Routes.painting_path(conn, :show, painting))
  #       end
  # 
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       if get_req_header(conn, "x-requested-with") == ["XMLHttpRequest"] do
  #         conn
  #         |> put_resp_content_type("application/json")
  #         |> json(%{status: "error", errors: changeset})
  #       else
  #         render(conn, :new, changeset: changeset)
  #       end
  #   end
  # end
  
  def create(conn, %{"painting" => painting_params}) do
    case Baseball.create_painting(painting_params) do
      {:ok, _painting} ->
        conn
        |> put_flash(:info, "Painting created successfully.")
        |> redirect(to: ~p"/paintings")
        # |> redirect(to: ~p"/paintings/#{painting}")
        # |> redirect(to: Routes.painting_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end


  # ai added
  # def reload_table(conn, _params) do
  #   paintings = Baseball.list_paintings()
  #   render(conn, "_painting_table.html", paintings: paintings)
  # end
  
  # ai
  def delete_all(conn, _params) do
    Hello.Repo.delete_all(Hello.Baseball.Painting)
    conn
    |> put_flash(:info, "All paintings deleted successfully.")
    |> redirect(to: ~p"/paintings")
    
    paintings = Baseball.list_paintings()
    render(conn, :index, paintings: paintings)
  end
  
end
