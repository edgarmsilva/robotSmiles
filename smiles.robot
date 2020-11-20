*** Settings ***
Resource    base.robot

Test Setup      newSession  
Test Teardown   closeSession

*** Variables ***
${title}            Milhas para você voar ainda mais - Smiles
${buscaVoos}        css:li[class*=search-voos]
${inputFrom}        id:inputOrigin
${inputTo}          id:inputDestination

${departure}        css:input[id*=departure_date]
${return}           css:input[id*=return_date]
${btn_Confirmar}    xpath://button[contains(text(), 'Confirmar')]
${btn_BuscaVoo}     id:submitFlightSearch

${title_sugerido}     css:.pst1 span

${calendarFrom}     Get WebElement  xpath://body/div[@id='ui-datepicker-div']/div[@class='ui-datepicker-group ui-datepicker-group-first']
${calendarTo}       xpath://body/div[@id='ui-datepicker-div']/div[@class='ui-datepicker-group ui-datepicker-group-last']

${ida}              "#firstFlights article[id*='flightsArticle']"




# variáveis do retorno dos vôos:
${btn_detalhes}         css:#firstFlights article[id*='flightsArticle'] div.details-bt







*** Test Cases ***
Acessando o site da Smiles
    [tags]              gru_cdg

    ${dayFrom} =        Get Current Date    increment=1 day
    # ${dayTo} =      Get Current Date    increment=5 day
    ${dayDeparture} =               Convert Date    ${dayFrom}  datetime
    # ${dayReturn} =                  Convert Date    ${dayTo}  datetime
    # log to console      dia ${dayDeparture.day}
    # log to console      mês ${dayDeparture.month}
    # log to console      Ano ${dayDeparture.year}
    # log to console      ${dayReturn}

    ${type_of}          Evaluate        type($title)
    log to console      Tipo: ${type_of}

    


    Title Should Be                 ${title}
    Click Element                   ${buscaVoos}
    Input Text                      ${inputFrom}        São Paulo (GRU)
    Press Keys                      ${inputFrom}        TAB
    Input Text                      ${inputTo}          Paris (CDG)
    Press Keys                      ${inputFrom}        TAB
    Click Element                   ${departure}
    selectDepartureDay              ${dayDeparture.day}
    selectArrivalDay                15
    Click Element                   ${btn_Confirmar}
    Click Element                   ${btn_BuscaVoo}
    
    Wait Until Element Is Visible   ${title_sugerido}

    ${voos_ida}                     Get WebElements     css:#firstFlights article[id*='flightsArticle']
    ${voos_volta}                   Get WebElements     css:#secondFlights article[id*='flightsArticle']
    # ${voos_ida}                     Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.payment-options ul li span
    # ${voos_volta}                   Get WebElements     css:#secondFlights article[id*='flightsArticle'] div.payment-options ul li span

    ${btn_detalhes}=            Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.details-bt
    ${company_thumbnails}=      Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.compThumb img.visible-desktop

    FOR    ${element}    IN    @{company_thumbnails}
        
    ${url}=     Get Element Attribute       ${element}   src
    log to console      url: ${url}

    
    
    END


    validaVoosIda                   ${voos_ida}
    
    
    # Sleep                           5
    


*** Keywords ***

selectDepartureDay
    [Arguments]     ${departureDay}  
    ${elements}=    Get WebElements    //div[@id='ui-datepicker-div']/div[@class='ui-datepicker-group ui-datepicker-group-first']/table/tbody/tr/td[contains(a,'${departureDay}')]
    Click Element   ${elements[0]}

selectArrivalDay
    [Arguments]     ${arrDay}  
    ${elements}=    Get WebElements    //div[@id='ui-datepicker-div']/div[@class='ui-datepicker-group ui-datepicker-group-last']/table/tbody/tr/td[contains(a,'${arrDay}')]
    Click Element   ${elements[0]}

validaVoosIda
    [Arguments]     ${voos_ida}
    
    ${size}=        Get Length      ${voos_ida}

    log to console      Tamanho: ${size}



    # ${elem}    Get Webelement    locator
    # ${child elems}    Call Method    ${elem}    find_element_by_class_name    foo



    FOR    ${element}    IN    @{voos_ida}

        ${url}=     Get Element     ${element}  div.payment-options div.column-miles div.column-header
        log to console      url: ${url.text}

        # ${child_elems}=      Get Parent Webelement       ${element} .miles .club span
        # log to console      get ${element} type
        # log to console      get ${voos_ida} type
        # ${type_ABC}         Evaluate        type($element)
        # ${type_voos}         Evaluate        type($voos_ida)
        # log to console      Tipo: ${type_ABC}
        # log to console      Tipo: ${type_voos}

        # log to console      Texto ${child_elems.text}
        # Page should contain image   ${element id}
        # Element should be visible   ${element id}
        
        # log to console      Dia selecionado: ${element.text}
        # Click Element       ${element}
        # Run Keyword If	    """${element.text}""" == """${Firstday}"""	Exit For Loop
    END


# Nome da companhia aérea
# Informar se o logo da companhia carregou na tela ou não
# Se é voo de ida ou volta
# Número do voo
# Data e hora de partida e de chegada
# Preço (Milhas e Smiles & Money)
