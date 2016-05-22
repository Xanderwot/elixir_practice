defmodule HelloPhoenix.ImageController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Image
  alias HelloPhoenix.Product

  import Ecto.Query

  plug :scrub_params, "image" when action in [:create, :update]

  def index(conn, %{"product_id" => product_id}) do
    images = Repo.all(Image |> where(product_id: ^product_id))
    render(conn, "index.json", images: images || [])
  end

  def create(conn, %{"image" => image_params, "product_id" => product_id}) do
    changeset = Image.changeset(%Image{}, Map.merge(image_params, %{"product_id" => product_id}))
    case Repo.insert(changeset) do
      {:ok, image} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", product_image_path(conn, :show, product_id, image))
        |> render("show.json", image: image)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HelloPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "product_id" => product_id}) do
    try do
      image = Repo.get_by!(Image, id: id, product_id: product_id)
      render(conn, "show.json", image: image)
    rescue
      e in Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> render(HelloPhoenix.ErrorView, "404.json", message: e.message)
    end
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Repo.get!(Image, id)
    changeset = Image.changeset(image, image_params)

    case Repo.update(changeset) do
      {:ok, image} ->
        render(conn, "show.json", image: image)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HelloPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Repo.get!(Image, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(image)

    send_resp(conn, :no_content, "")
  end
end
