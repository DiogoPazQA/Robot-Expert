*** Settings ***
Documentation        Ações da Feature de gestão de planos

*** Variable ***
${TITLE_FIELD}       css=input[name=title]
${DURATION_FIELD}    css=input[name=duration]
${PRICE_FIELD}       css=input[name=price]
${TOTAL_FIELD}       css=input[name=total]

*** Keywords ***
Go To Form Plans
    Set Strict Mode            False
    Click                      css=a[href$="planos/new"]
    Wait For Elements State    h1 >> text=Novo plano                                                  visible                5

Fill Plan Form
    [Arguments]                ${plan}
    Fill Text                  ${TITLE_FIELD}                                                         ${plan.title}
    Fill Text                  ${DURATION_FIELD}                                                      ${plan.duration}
    Fill Text                  ${PRICE_FIELD}                                                         ${plan.price}

New Plan
    [Arguments]                ${plan}
    Fill Text                  ${TITLE_FIELD}                                                         ${plan.title}
    Fill Text                  ${DURATION_FIELD}                                                      ${plan.duration}
    Fill Text                  ${PRICE_FIELD}                                                         ${plan.price}
    Submit Form

Update A Plan
    [Arguments]                ${plan}
    Fill Text                  ${TITLE_FIELD}                                                         ${plan['title']}
    Fill Text                  ${DURATION_FIELD}                                                      ${plan['duration']}
    Fill Text                  ${PRICE_FIELD}                                                         ${plan['price']}
    Submit Form

Total Plan Should Be
    [Arguments]                ${total}
    Get Attribute              ${TOTAL_FIELD}                                                         value                  ==    ${total}

Search Plan By Name
    [Arguments]                ${title}
    Fill Text                  css=input[placeholder="Buscar plano"]                                  ${title}

Go To Plan Update Form
    [Arguments]                ${title}
    Click                      xpath=//td[contains(text(), "${title}")]/..//a[@class="edit"]
    Wait For Elements State    css=h1 >> text=Edição de plano                                         visible                5

Plan Name Should Be Visible
    [Arguments]                ${title}
    Wait For Elements State    css=table tbody tr >> text=${title}                                    visible                5

Request Removal By Title
    [Arguments]                ${title}
    Click                      xpath=//td[contains(text(), "${title}")]/../td//button[@id="trash"]

Plan Should Not Visible
    [Arguments]                ${title}
    Wait For Elements State    xpath=//td[contains(text(), "${title}")]                               detached               5

Plan Should Be Visible
    [Arguments]                ${title}
    Wait For Elements State    xpath=//td[contains(text(), "${title}")]                               visible                5