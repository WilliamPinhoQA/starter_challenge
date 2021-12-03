**Settings**
Documentation   Home Page of Nbank
Resource        ${EXECDIR}/resources/base.robot
Test Setup      Start Session
Test Teardown   End Session


**Test Cases**
Balance Should Exist
#PASS
    ${balance}  Set Variable   1000
    ${name}     Set Variable    Papito 
    Get Text    xpath=//a[contains(text(),"Olá ${name}, seu saldo é R$ ${balance}")] 


Send Pix
#PASS
    [Tags]              pix
    &{user_data}        Create Dictionary
    ...                 name=Papito
    ...                 bank=C6 Bank
    ...                 pix= QANINJA MELHOR CURSO DE AUTOMACAO LTDA
    ...                 value=100
    ...                 transaction=Envio de PIX
    ...                 balance=1000
    Send Pix            ${user_data}       
    Check Transaction   ${user_data}


Send Pix Decimal Value
#BUG
    [Tags]              decimal
    &{user_data}        Create Dictionary
    ...                 name=Papito
    ...                 bank=Next
    ...                 pix= QANINJA
    ...                 value=888.77
    ...                 transaction=Envio de PIX
    ...                 balance=1000
    Send Pix            ${user_data}       
    Check Transaction   ${user_data}


Send Pix With Zero Value
#PASS
    [Tags]              zero
     &{user_data}       Create Dictionary
    ...                 name=Papito
    ...                 bank=Nubank
    ...                 pix= QAWILLIAM
    ...                 value=0
    ...                 transaction=Envio de PIX
    ...                 balance=1000
    ...                 error_message=Oops. Transferir ZERO é osso hein...
    Send Pix            ${user_data}       
    Assert Error Message    ${user_data}


Send Pix With Negative Value
#BUG
     &{user_data}       Create Dictionary
    ...                 name=Papito 
    ...                 bank=Neon
    ...                 pix= QAWILLIAM
    ...                 value=-89
    ...                 transaction=Envio de PIX
    ...                 balance=1000
    ...                 error_message=Oops. Valor para PIX incorreto...
    Send Pix            ${user_data}       
    Assert Error Message    ${user_data}
