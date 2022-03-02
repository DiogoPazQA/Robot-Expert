*** Settings ***
Documentation    Suite de testes do login ao sistema
Resource         ${EXECDIR}/resources/base.robot
Suite Setup      Start Browser Session
Test Teardown    Take Screenshot

*** Test Case ***
Cenario: Login do Administrador
    Go To Login Page
    Login With                  admin@bodytest.com               pwd123
    User Should Be Logged In    Administrador
    [Teardown]                  Clear LS And Take Screenshot

Cenario: Senha incorreta
    Go To Login Page
    Login With                  admin@bodytest.com               abc123
    Toaster Text Should Be      Usuário e/ou senha inválidos.
    [Teardown]                  Thinking And Take Screenshot     2

Cenario: Email incorreto
    Go To Login Page
    Login With                  admin&bodytest.com               pwd123
    Alert Text Should Be        Informe um e-mail válido

Cenario: Email não cadastrado
    Go To Login Page
    Login With                  usuario@bodytest.com             abc123
    Toaster Text Should Be      Usuário e/ou senha inválidos.
    [Teardown]                  Thinking And Take Screenshot     2

Cenario: Senha não informada
    Go To Login Page
    Login With                  admin@bodytest.com               ${EMPTY}
    Alert Text Should Be        A senha é obrigatória


Cenario: Email não informada
    Go To Login Page
    Login With                  ${EMPTY}                         pwd123
    Alert Text Should Be        O e-mail é obrigatório

Cenario: Email e senha não informada
    Go To Login Page
    Login With                  ${EMPTY}                         ${EMPTY}
    Alert Text Should Be        O e-mail é obrigatório
    Alert Text Should Be        A senha é obrigatória

