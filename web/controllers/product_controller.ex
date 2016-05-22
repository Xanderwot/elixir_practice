defmodule HelloPhoenix.ProductController do
  use HelloPhoenix.Web, :controller

  alias HelloPhoenix.Product

  plug :scrub_params, "product" when action in [:create, :update]

  def index(conn, _params) do
    products = Product |> Repo.all |> Repo.preload([:images])
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    changeset = Product.changeset(%Product{}, product_params)

    case Repo.insert(changeset) do
      {:ok, product} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", product_path(conn, :show, product))
        |> render("show.json", product: product)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HelloPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Product |> Repo.get!(id) |> Repo.preload([:images])
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Repo.get!(Product, id)
    changeset = Product.changeset(product, product_params)

    case Repo.update(changeset) do
      {:ok, product} ->
        render(conn, "show.json", product: product)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HelloPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product)

    send_resp(conn, :no_content, "")
  end
end
