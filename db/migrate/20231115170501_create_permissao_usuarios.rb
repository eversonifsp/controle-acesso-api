class CreatePermissaoUsuarios < ActiveRecord::Migration[6.1]
  def change
    create_table :permissao_usuarios do |t|
      t.date :data_inicio, null: false
      t.date :data_fim, null: false
      t.references :usuario, null: false, foreign_key: true
      t.string :descricao_permissao

      t.timestamps
    end
  end
end
