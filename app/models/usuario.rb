class Usuario < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self,
         authentication_keys: [:prontuario]

  has_many :permissao_usuarios
  has_many :registro_acesso_usuarios

  has_one_attached :foto

  enum tipo: [:outros_colaboradores_campus, :aluno, :admin, :secretario, :porteiro, :visitante]
  
  def admin?
    tipo == 'admin'
  end

  def secretario?
    tipo == 'secretario'
  end

  def porteiro?
    tipo == 'porteiro'
  end

  def adulto?
    Time.now.to_date >= (data_nascimento.to_date + 18.years)
  end

  def autorizado?
    if tipo == 'aluno'
      adulto? || menor_idade_autorizado?
    else 
      true
    end  
  end
  
  private
  
  def menor_idade_autorizado?
    permissao_usuarios.where('data_inicio <= ? AND data_fim >= ?', Time.now, Time.now).any?
  end
end
