defmodule HelloPhoenix.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :path, :string
      add :product_id, references(:products, on_delete: :nothing)

      timestamps
    end
    create index(:images, [:product_id])

  end
end
