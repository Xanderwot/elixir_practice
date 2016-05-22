defmodule HelloPhoenix.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :price, :float
      add :description, :text

      timestamps
    end

  end
end
