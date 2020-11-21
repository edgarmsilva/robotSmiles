*** Settings ***
Resource    basetraining.robot
Test Setup      newSession  
Test Teardown   closeSession

*** Test Cases ***

Acessar a lista
    ${lista}     Get WebElements  css:ul li a 

    FOR    ${element}    IN    @{lista}

        # ${filho}=       Get WebElement      css:${element} a
        log to console      ${element.text}

    END

     ${size}=        Get Length      ${lista}

    log to console  ----------------------------------------------

     FOR    ${index}    IN RANGE    @{size}
         log to console      ${lista[index]}
    END