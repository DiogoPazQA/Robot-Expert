*** Settings ***
Documentation    Atualização de alunos
Resource         ${EXECDIR}/resources/base.robot
Suite Setup      Start Admin Session
Test Teardown    Take Screenshot



*** Test Case ***
Cenario: Atualizar um aluno já cadastrado
    ${fixture}                   Get JSON                         students-update.json
    ${kamalakhan}                Set Variable                     ${fixture['before']}
    ${msmarvel}                  Set Variable                     ${fixture['after']}

    Remove Student By Name       ${kamalakhan['name']}
    Remove Student By Name       ${msmarvel['name']}
    Insert Student               ${kamalakhan}
    Go To Students

    Search Student By Name       ${kamalakhan['name']}
    Go To Student Update Form    ${kamalakhan['email']}
    Update A Student             ${msmarvel}
    Toaster Text Should Be       Aluno atualizado com sucesso.
    [Teardown]                   Thinking And Take Screenshot     2