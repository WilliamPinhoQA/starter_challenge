**Settings**
Documentation   Nbank Custom Actions
Library         DateTime

**Keywords**

Send Pix
    [Arguments]         ${user_data}
    Click               text=Fazer PIX
    Get Text            css=.modal-card-title   ==  PIX
    Select Options By   css=.select select      value   ${user_data}[bank]

    # Check Placeholder info
    Get Text            css=input[placeholder="Chave PIX"]
    Get Text            css=input[placeholder="Valor"]

    Fill Text           id=chave-pix    ${user_data}[pix]
    Fill Text           id=valor        ${user_data}[value]

    Click               text=Enviar PIX

Check Transaction
    [Arguments]         ${user_data}
    ${date}             Get Current Date    result_format=%d/%m/%Y
    ${element}          Set Variable    xpath=//td[contains(text(),"${user_data}[pix]")]/..
    ${new_balance}      Evaluate   ${user_data}[balance] - ${user_data}[value]
 
    IF      isinstance(${new_balance}, float)
            ${new_balance}  Convert to Number  ${new_balance}  2
    END
   
    ${code}             Get text    xpath=//td[contains(text(),"${user_data}[pix]")]/..//td[@data-label="Código"]
    ${code_length}      Get Length    ${code}
    Should Be Equal As Strings     ${code_length}     12          

    Wait for Elements State        ${element}         visible     5

    Get text            ${element}      contains        ${user_data}[pix]
    Get text            ${element}      contains        ${user_data}[value]
    Get text            ${element}      contains        ${user_data}[transaction]
    Get text            ${element}      contains        ${date}

    Wait for Elements State        xpath=//a[contains(text(),"Olá ${user_data}[name]")]
    ...         visible         5

    Get Text    xpath=//a[contains(text(),"Olá ${user_data}[name]")]     ==  Olá ${user_data}[name], seu saldo é R$ ${new_balance}


Assert Error Message
    [Arguments]         ${user_data}
    Get Text            css=.media-content      ==       ${user_data}[error_message]                      