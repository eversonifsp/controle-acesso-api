class Usuario < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :registro_acesso_usuarios

  has_one_attached :foto

  enum tipo: [:outros_colaboradores_campus, :aluno, :admin, :secretario, :porteiro, :visitante]
  enum turno: [:manha, :tarde]

  # Substitui a forma padrao do devise de autenticar, portando atraves do 
  # atributo login é possivel saber se é um cpf, prontuario ou email
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(cpf) = :value OR lower(prontuario) = :value OR lower(email) = :value", { value: login.downcase }]).first
    end
  end

  def admin?
    tipo == 'admin'
  end

  def email_required?
    false
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
