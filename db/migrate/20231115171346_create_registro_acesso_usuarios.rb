class CreateRegistroAcessoUsuarios < ActiveRecord::Migration[6.1]
  def change
    create_table :registro_acesso_usuarios do |t|
      t.references :usuario, null: false, foreign_key: true
      t.integer :tipo, null: false, default: 0

      t.timestamps
    end
  end
end
