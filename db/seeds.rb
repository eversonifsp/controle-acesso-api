# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Usuario.create(email: 'everson@gmail.com', tipo: 'aluno', nome: 'Everson', password: '123123', cpf: '000-000-000-00', prontuario: 'CB3026353')
Usuario.create(email: 'jackson@gmail.com', tipo: 'aluno', nome: 'Jackson', password: '123123', cpf: '000-000-000-01', prontuario: 'CB3013189')

Usuario.create(email: 'porteiro@gmail.com', tipo: 'porteiro', nome: 'Jose', password: '123123', cpf: '000-000-000-02', prontuario: 'CB1333333')

Usuario.create(email: 'nelson@gmail.com', tipo: 'outros_colaboradores_campus', nome: 'Nelson', password: '123123', cpf: '000-000-000-03', prontuario: 'CB1333331')

Usuario.create(email: 'lula13@gmail.com', tipo: 'visitante', nome: 'Lula', password: '123123', cpf: '000-000-000-04')

Usuario.create(email: 'secretaria@gmail.com', tipo: 'secretario', nome: 'Paolla', password: '123123', cpf: '000-000-000-05')

Usuario.create(email: 'admin@gmail.com', tipo: 'admin', nome: 'Rogerio', password: '123123', cpf: '000-000-000-06')