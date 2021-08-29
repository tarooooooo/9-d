class AddBooksToRate < ActiveRecord::Migration[5.2]
  def change
    add_column :Books, :rate, :float
  end
end
