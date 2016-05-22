defmodule HelloPhoenix.ProductView do
  use HelloPhoenix.Web, :view

  alias HelloPhoenix.ProductView
  alias HelloPhoenix.ImageView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      images: render_many(product.images, ImageView, "image.json")
    }
  end
end
