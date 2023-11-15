u = Usuario.find_by(email: 'everson@gmail.com')

u.registro_acesso_usuarios.create(tipo: 'entrada')
u.registro_acesso_usuarios.create(tipo: 'saida')

u.registro_acesso_usuarios.create(tipo: 'entrada')
u.registro_acesso_usuarios.create(tipo: 'saida')

u.registro_acesso_usuarios.create(tipo: 'entrada')
u.registro_acesso_usuarios.create(tipo: 'saida')

u = Usuario.find_by(email: 'jackson@gmail.com')

u.registro_acesso_usuarios.create(tipo: 'entrada')
u.registro_acesso_usuarios.create(tipo: 'saida')

u.registro_acesso_usuarios.create(tipo: 'entrada')
u.registro_acesso_usuarios.create(tipo: 'saida')

u.registro_acesso_usuarios.create(tipo: 'entrada')
u.registro_acesso_usuarios.create(tipo: 'saida')