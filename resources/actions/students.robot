*** Settings ***
Documentation         Ações da Feature de gestão de alunos

*** Variable ***
${NAME_FIELD}         css=input[name=name]
${EMAIL_FIELD}        css=input[name=email]
${AGE_FIELD}          css=input[name=age]
${WEIGHT_FIELD}       css=input[name=weight]
${FEET_TALL_FIELD}    css=input[name=feet_tall]

*** Keywords ***
## Forms
New Student
    [Arguments]                ${student}
    Fill Text                  ${NAME_FIELD}                                                          ${student.name}
    Fill Text                  ${EMAIL_FIELD}                                                         ${student.email}
    Fill Text                  ${AGE_FIELD}                                                           ${student.age}
    Fill Text                  ${WEIGHT_FIELD}                                                        ${student.weight}
    Fill Text                  ${FEET_TALL_FIELD}                                                     ${student.feet_tall}
    Submit Form

Update A Student
    [Arguments]                ${student}
    Fill Text                  ${NAME_FIELD}                                                          ${student['name']}
    Fill Text                  ${EMAIL_FIELD}                                                         ${student['email']}
    Fill Text                  ${AGE_FIELD}                                                           ${student['age']}
    Fill Text                  ${WEIGHT_FIELD}                                                        ${student['weight']}
    Fill Text                  ${FEET_TALL_FIELD}                                                     ${student['feet_tall']}
    Submit Form

Search Student By Name
    [Arguments]                ${name}
    Fill Text                  css=input[placeholder="Buscar aluno"]                                  ${name}

## Links & Buttons
Go To Form Students
    Set Strict Mode            False
    Click                      css=a[href$="alunos/new"]
    Wait For Elements State    h1 >> text=Novo Aluno                                                  visible                    5

Go To Student Update Form
    [Arguments]                ${email}
    Click                      xpath=//td[contains(text(), "${email}")]/..//a[@class="edit"]
    Wait For Elements State    css=h1 >> text=Edição de aluno                                         visible                    5

Request Removal By Email
    [Arguments]                ${email}
    Click                      xpath=//td[contains(text(), "${email}")]/../td//button[@id="trash"]

## Validations
Student Should Not Visible
    [Arguments]                ${email}
    Wait For Elements State    xpath=//td[contains(text(), "${email}")]                               detached                   5

Student Should Be Visible
    [Arguments]                ${email}
    Wait For Elements State    xpath=//td[contains(text(), "${email}")]                               visible                    5

Student Name Should Be Visible
    [Arguments]                ${name}
    Wait For Elements State    css=table tbody tr >> text=${name}                                     visible                    5



