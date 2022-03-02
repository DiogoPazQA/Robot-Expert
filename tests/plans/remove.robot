*** Settings ***
Documentation    Remover Planos
Resource         ${EXECDIR}/resources/base.robot
Suite Setup      Start Admin Session
Test Setup       Take Screenshot


*** Test Case ***
Cenario: Remover plano cadastrado
    &{plan}                     Create Dictionary               title=Plano Bronze     duration=6    price=12.99    total=R$ 77,94
    Insert Plan                 ${plan}
    Go To Plans
    Search Plan By Name         ${plan.title}
    Request Removal By Title    ${plan.title}
    Confirm Removal
    Toaster Text Should Be      Plano removido com sucesso
    Plan Should Not Visible     ${plan.title}
    [Teardown]                  Thinking And Take Screenshot    2

Cenario: Desistir da exclusão
    &{plan}                     Create Dictionary               title=Plano Madeira    duration=3    price=12.99    total=R$ 38,97
    Insert Plan                 ${plan}
    Go To Plans
    Reload
    Search Plan By Name         ${plan.title}
    Request Removal By Title    ${plan.title}
    Cancel Removal
    Plan Should Be Visible      ${plan.title}