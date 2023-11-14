class AddJtiToUsuario < ActiveRecord::Migration[6.1]
  def change
    add_column :usuarios, :jti, :string
    add_index :usuarios, :jti
  end
end
