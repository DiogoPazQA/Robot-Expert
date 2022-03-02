*** Settings ***
Documentation    Remover Alunos
Resource         ${EXECDIR}/resources/base.robot
Suite Setup      Start Admin Session
Test Setup       Take Screenshot


*** Test Case ***
Cenario: Remover aluno cadastrado

    &{student}                    Create Dictionary               name=Alberto Ascari    email=albertoascari@bodytest.com    age=69    weight=97    feet_tall=1.92
    Insert Student                ${student}
    Go To Students
    Search Student By Name        ${student.name}
    Request Removal By Email      ${student.email}
    Confirm Removal
    Toaster Text Should Be        Aluno removido com sucesso.
    Student Should Not Visible    ${student.email}
    [Teardown]                    Thinking And Take Screenshot    2

Cenario: Desistir da exclusão
    &{student}                    Create Dictionary               name=Nino Farina       email=ninofarina@bodytest.com       age=72    weight=67    feet_tall=1.52
    Insert Student                ${student}
    Go To Students
    Reload
    Search Student By Name        ${student.name}
    Request Removal By Email      ${student.email}
    Cancel Removal
    Student Should Be Visible     ${student.email}

