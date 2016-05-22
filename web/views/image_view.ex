defmodule HelloPhoenix.ImageView do
  use HelloPhoenix.Web, :view

  def render("index.json", %{images: images}) do
    %{data: render_many(images, HelloPhoenix.ImageView, "image.json")}
  end

  def render("show.json", %{image: image}) do
    %{data: render_one(image, HelloPhoenix.ImageView, "image.json")}
  end

  def render("image.json", %{image: image}) do
    %{id: image.id,
      path: image.path,
      product_id: image.product_id}
  end
end
