class AddProntuarioToUsuario < ActiveRecord::Migration[6.1]
  def change
    add_column :usuarios, :prontuario, :string, unique: true
  end
end
