*** Settings ***
Library     SeleniumLibrary
Library     DateTime 

*** Variables ***
${url}              https://training-wheels-protocol.herokuapp.com/

    

*** Keywords ***
newSession
    ${options}=     Evaluate  sys.modules['selenium.webdriver.chrome.options'].Options()    sys
    Call Method     ${options}    add_argument    --disable-notifications
    ${driver}=      Create Webdriver    Chrome    options=${options}
    Go To           ${url} 
    # Open Browser        ${url}     chrome
    Maximize Browser Window
    Set Selenium Timeout	30 seconds

closeSession
    # Capture Page Screenshot
    Close Browser