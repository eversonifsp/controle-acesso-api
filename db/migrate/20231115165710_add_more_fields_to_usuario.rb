class AddMoreFieldsToUsuario < ActiveRecord::Migration[6.1]
  def change
    add_column :usuarios, :nome, :string
    add_column :usuarios, :cpf, :string
    add_column :usuarios, :tipo, :string
    add_column :usuarios, :telefone, :string
    add_column :usuarios, :data_nascimento, :datetime
  end
end
