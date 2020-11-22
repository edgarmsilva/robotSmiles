*** Settings ***
Resource    ../resources/base.robot

Test Setup      newSession  
Test Teardown   closeSession

*** Variables ***

${title}                Milhas para você voar ainda mais - Smiles
${btn_accept_cookies}   css:button.btn-accept
${buscaVoos}            css:li[class*=search-voos]
${inputFrom}            id:inputOrigin
${inputTo}              id:inputDestination
${departure}            css:input[id*=departure_date]
${return}               css:input[id*=return_date]
${btn_Confirmar}        xpath://button[contains(text(), 'Confirmar')]
${btn_BuscaVoo}         id:submitFlightSearch
${title_sugerido}       css:.pst1 span
${calendarFrom}         Get WebElement  xpath://body/div[@id='ui-datepicker-div']/div[@class='ui-datepicker-group ui-datepicker-group-first']
${calendarTo}           xpath://body/div[@id='ui-datepicker-div']/div[@class='ui-datepicker-group ui-datepicker-group-last']
${ida}                  "#firstFlights article[id*='flightsArticle']"
${btn_detalhes}         css:#firstFlights article[id*='flightsArticle'] div.details-bt

*** Test Cases ***
Pesquisar Vôos GRU - CDG
    [tags]              gru_cdg
    ${tag}              Set Variable        gru_cdg
    Set Global Variable     ${tag}
    Create File       ${EXECDIR}/relatorio/${tag}.txt
    ${dayFrom} =        Get Current Date    increment=1 day
    ${dayDeparture} =   Convert Date        ${dayFrom}  datetime
    ${from}             Set Variable        São Paulo (GRU)
    ${to}               Set Variable        Paris (CDG)

    acess_page  ${from}  ${to}  ${dayDeparture}
    
    ${qtde_voos_ida}=               Get WebElements     css:#firstFlights article[id*='flightsArticle'] 
    ${qtde_voos_volta}=             Get WebElements     css:#secondFlights article[id*='flightsArticle'] 
    ${btn_detalhes_ida}=            Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.details-bt a span
    ${btn_detalhes_volta}=          Get WebElements     css:#secondFlights article[id*='flightsArticle'] div.details-bt a span
    
    print_relatorio_voos_ida        ${qtde_voos_ida}    ${qtde_voos_volta}      ${btn_detalhes_ida}     
    print_relatorio_voos_volta      ${qtde_voos_ida}    ${qtde_voos_volta}      ${btn_detalhes_volta}
    
Pesquisar Vôos GRU - AUH
    [tags]              gru_auh
    ${tag}              Set Variable        gru_auh
    Set Global Variable     ${tag}
    Create File       ${EXECDIR}/relatorio/${tag}.txt
    ${dayFrom} =        Get Current Date    increment=1 day
    ${dayDeparture} =   Convert Date        ${dayFrom}  datetime
    ${from}             Set Variable        São Paulo (GRU)
    ${to}               Set Variable        Abu Dhabi (AUH)

    acess_page  ${from}  ${to}  ${dayDeparture}

    ${qtde_voos_ida}=               Get WebElements     css:#firstFlights article[id*='flightsArticle'] 
    ${qtde_voos_volta}=             Get WebElements     css:#secondFlights article[id*='flightsArticle'] 
    ${btn_detalhes_ida}=            Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.details-bt a span
    ${btn_detalhes_volta}=          Get WebElements     css:#secondFlights article[id*='flightsArticle'] div.details-bt a span
    
    print_relatorio_voos_ida        ${qtde_voos_ida}        ${qtde_voos_volta}      ${btn_detalhes_ida}     
    print_relatorio_voos_volta      ${qtde_voos_ida}        ${qtde_voos_volta}      ${btn_detalhes_volta}
    
Pesquisar Vôos GRU - AMS
    [tags]              gru_ams
    ${tag}              Set Variable        gru_ams
    Set Global Variable     ${tag}
    Create File       ${EXECDIR}/relatorio/${tag}.txt
    ${dayFrom} =        Get Current Date    increment=1 day
    ${dayDeparture} =   Convert Date        ${dayFrom}  datetime

    ${from}             Set Variable        São Paulo (GRU)
    ${to}               Set Variable        Amsterdam (AMS)

    acess_page  ${from}  ${to}  ${dayDeparture}

    ${qtde_voos_ida}=               Get WebElements     css:#firstFlights article[id*='flightsArticle'] 
    ${qtde_voos_volta}=             Get WebElements     css:#secondFlights article[id*='flightsArticle'] 
    ${btn_detalhes_ida}=            Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.details-bt a span
    ${btn_detalhes_volta}=          Get WebElements     css:#secondFlights article[id*='flightsArticle'] div.details-bt a span

    print_relatorio_voos_ida        ${qtde_voos_ida}        ${qtde_voos_volta}      ${btn_detalhes_ida}     
    print_relatorio_voos_volta      ${qtde_voos_ida}        ${qtde_voos_volta}      ${btn_detalhes_volta}
