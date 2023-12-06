class UsuariosController < ApplicationController
  require 'csv'
  before_action :authenticate_usuario!

  before_action :checar_admin, only: [:atualizar_usuario, :listar_usuarios, :importar_usuarios]
  before_action :checar_secretario, only: [:listar_alunos]
  before_action :checar_porteiro, only: [:criar_visitante]
  before_action :setar_usuario, only: [:atualizar_usuario]

  def importar_usuarios
    begin
      Usuario.transaction do
        Usuario.where.not(tipo: 'admin').destroy_all
  
        arquivo_csv = params[:file].tempfile
  
        CSV.foreach(arquivo_csv, headers: true, col_sep: ';') do |row|
          data_to_insert = row.to_h.slice('nome', 'cpf', 'prontuario', 'email', 'password')
          @usuario = Usuario.new(data_to_insert)
          @usuario.password = Devise.friendly_token if @usuario.password.blank?
          @usuario.save!
        end
  
        render json: { mensagem: "IMPORTADO COM SUCESSO" }
      end
    rescue StandardError => e
      render json: { mensagem: e }, status: :unprocessable_entity
    end
  end
  
  def criar_visitante
    @usuario = Usuario.new(usuario_params)
    @usuario.tipo = :visitante
    @usuario.password = Devise.friendly_token.first(8)
    @usuario.registro_acesso_usuarios.new(tipo: :entrada)

    if @usuario.save
      render :show, status: :created
    else
      render json: @usuario.errors, status: :unprocessable_entity
    end
  end

  def listar_usuarios
    @usuarios = Usuario.all
    render :index
  end

  def listar_alunos
    @usuarios = Usuario.where(tipo: 'aluno')
    filtrar_por_prontuario if params[:prontuario].present?
    
    render :index
  end

  def atualizar_usuario
    if @usuario.update(params_usuario)
      render :show
    else
      render json: { error: 'Não foi possível atualizar o usuário!' }, status: :unprocessable_entity
    end
  end

  private

  def usuario_params
    if action_name == 'importar_usuarios'
      params.permit(:file)
    else
      params.permit(:email, :nome, :cpf, :telefone, :foto)
    end
  end

  def filtrar_por_prontuario
    @usuarios = @usuarios.where("prontuario LIKE ?", "%#{params[:prontuario]}%")
  end

  def setar_usuario
    @usuario = Usuario.find(params[:id])
  end

  def params_usuario
    params.permit(:tipo)
  end
end
