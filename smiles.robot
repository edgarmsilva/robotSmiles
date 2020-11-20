*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${url}              http://www.smiles.com.br
${check_thor}       id:thor
${check_iron}       css:input[value='iron-man']
${check_panther}    xpath://*[@id='checkboxes']/input[7]

*** Test Cases ***
Acessando o site da Smiles
    Open Browser        ${url}     chrome
    Title Should Be     Milhas para você voar ainda mais - Smiles
    # Go To                           ${url}/checkboxes
    # Select Checkbox                 ${check_thor}
    # Checkbox Should Be Selected     ${check_thor}
    # Sleep                           5
    Close Browser