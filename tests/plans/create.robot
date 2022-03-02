*** Settings ***
Documentation    Cadastro de Planos
Resource         ${EXECDIR}/resources/base.robot
Suite Setup      Start Admin Session
Test Teardown    Take Screenshot


*** Test Case ***
Cenario: Calcular preço total do plano
    &{plan}                   Create Dictionary                title=Plano Black            duration=12                            price=19,99             total=R$ 239,88
    Go To Plans
    Go To Form Plans
    Fill Plan Form            ${plan}
    Total Plan Should Be      ${plan.total}

Cenario: Novo Plano
    &{plan}                   Create Dictionary                title=Plano Black            duration=12                            price=19,99             total=R$ 239,88
    Remove Plan               ${plan.title}
    Go To Plans
    Go To Form Plans
    New Plan                  ${plan}
    Toaster Text Should Be    Plano cadastrado com sucesso
    [Teardown]                Thinking And Take Screenshot     2

Cenario: Campos Título e Duração devem ser obrigatórios
    @{expected_alerts}        Set Variable                     Informe o título do plano    Informe a duração do plano em meses
    @{got_alerts}             Create List
    Go To Plans
    Go To Form Plans
    Submit Form
    FOR                       ${index}                         IN RANGE                     1                                      3
    ${span}                   Get Required Alerts              ${index}
    Append To List            ${got_alerts}                    ${span}
    END
    Log                       ${expected_alerts}
    Log                       ${got_alerts}
    Lists Should Be Equal     ${expected_alerts}               ${got_alerts}

Cenario: Campo Preço do Plano deve ser obrigatório e maior do que zero
    &{plan}                   Create Dictionary                title=Plano Ferro            duration=12                            price=${EMPTY}          total=${EMPTY}
    ${expected_alert}         Set Variable                     O preço é obrigatório
    Go To Plans
    Go To Form Plans
    New Plan                  ${plan}
    ${got_alert}              Get Text                         xpath=//form//span
    Log                       ${expected_alert}
    Log                       ${got_alert}
    Should Be String          ${expected_alert}                ${got_alert}
    [Teardown]                Thinking And Take Screenshot     2

Cenario: Validação do Campo numérico
    [Template]                Check Type Field On Plan Form
    ${DURATION_FIELD}         number

Cenario: Validação do Campo Preço Mensal
    Go To Plans
    Go To Form Plans
    Get Attribute             ${PRICE_FIELD}                   value                        ==                                     0,00

Cenario: Preço Mensal não pode ser superior a 99 milhões
    &{plan}                   Create Dictionary                title=Plano Proibido         duration=12                            price=100.000.000,00    total=${EMPTY}
    Remove Plan               ${plan.title}
    Go To Plans
    Go To Form Plans
    New Plan                  ${plan}
    Toaster Text Should Be    Erro cadastrar aluno!
    [Teardown]                Thinking And Take Screenshot     2

Cenario: Limpeza dos Planos
    [tags]                    temp
    Remove Plan               Plano

*** Keywords ***
Check Type Field On Plan Form
    [Arguments]               ${element}                       ${type}
    Go To Plans
    Go To Form Plans
    Field Should Be Type      ${element}                       ${type}


