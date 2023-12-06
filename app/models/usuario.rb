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
  enum turno: [:manha, :tarde]

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
    return true unless turno.present?
    
    hora = turno == 'manha' ? 13 : 18

    hora_agora = Time.now
    hora_agora = Time.new(hora_agora.year, hora_agora.month, hora_agora.day, 20, 0, 0, hora_agora.utc_offset)
    hora_limite = Time.new(hora_agora.year, hora_agora.month, hora_agora.day, hora, 0, 0, hora_agora.utc_offset)

    hora_agora > hora_limite
  end
end
