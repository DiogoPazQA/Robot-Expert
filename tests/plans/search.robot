*** Settings ***
Documentation    Busca de planos
Resource         ${EXECDIR}/resources/base.robot
Suite Setup      Start Admin Session
Test Teardown    Take Screenshot



*** Test Case ***
Cenario: Busca exata
    ${plan}                         Create Dictionary      title=Plano Safira     duration=12    price=39.99    total=R$ 479,88
    Insert Plan                     ${plan}
    Go To Plans
    Search Plan By Name             ${plan.title}
    Plan Name Should Be Visible     ${plan.title}
    Total Items Should Be           1

Cenario: Registro não encontrado
    ${title}                        Set Variable           Plano Inexistente
    Remove Plan                     ${title}
    Go To Plans
    Search Plan By Name             ${title}
    Register Should Not Be Found

Cenario: Busca planos por um único termo
    ${fixture}                      Get JSON               plans-search.json
    ${plans}                        Set Variable           ${fixture['plans']}
    ${word}                         Set Variable           ${fixture['word']}
    ${total}                        Set Variable           ${fixture['total']}
    Remove Plan                     ${word}
    FOR                             ${item}                IN                     @{plans}
    Insert Plan                     ${item}
    END
    Go To Plans
    Search Plan By Name             ${word}
    FOR                             ${item}                IN                     @{plans}
    Plan Name Should Be Visible     ${item['duration']}
    END
    Total Items Should Be           ${total}