class AddMoreFieldsToUsuario < ActiveRecord::Migration[6.1]
  def change
    add_column :usuarios, :nome, :string
    add_column :usuarios, :cpf, :string, unique: true
    add_column :usuarios, :tipo, :integer, null: false, default: 0
    add_column :usuarios, :telefone, :string
    add_column :usuarios, :data_nascimento, :date
    add_column :usuarios, :turno, :integer
    add_column :usuarios, :autorizado_sair, :integer
  end
end
