*** Settings ***
Documentation    Ações de autorização

*** Keywords ***
Go To Login Page
    Go To          https://bodytest-web-drakke.herokuapp.com

Login With
    [Arguments]    ${email}                                     ${pass}
    Fill Text      css=input[name=email]                        ${email}
    Fill Text      css=input[placeholder*=senha]                ${pass}
    Click          text=Entrar

