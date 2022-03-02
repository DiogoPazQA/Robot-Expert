*** Settings ***
Documentation    Atualização de planos
Resource         ${EXECDIR}/resources/base.robot
Suite Setup      Start Admin Session
Test Teardown    Take Screenshot



*** Test Case ***
Cenario: Atualizar um plano já cadastrado
    ${fixture}                Get JSON                        plans-update.json
    ${safira_old}             Set Variable                    ${fixture['before']}
    ${safira_new}             Set Variable                    ${fixture['after']}

    Remove Plan               ${safira_old['title']}
    Remove Plan               ${safira_new['title']}
    Insert Plan               ${safira_old}
    Go To Plans

    Search Plan By Name       ${safira_old['title']}
    Go To Plan Update Form    ${safira_old['title']}
    Update A Plan             ${safira_new}
    Toaster Text Should Be    Plano atualizado com sucesso
    [Teardown]                Thinking And Take Screenshot    2