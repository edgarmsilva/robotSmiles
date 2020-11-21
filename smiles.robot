*** Settings ***
Resource    base.robot

Test Setup      newSession  
Test Teardown   closeSession

*** Variables ***

${title}            Milhas para você voar ainda mais - Smiles
${btn_accept_cookies}       css:button.btn-accept
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

    # ${type_of}          Evaluate        type($title)
    # log to console      Tipo: ${type_of}

    


    Title Should Be                 ${title}
    Click Element                   ${btn_accept_cookies}
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

    
    # pegar a quantidade de voos de ida:
    ${qtde_voos_ida}=                     Get WebElements     css:#firstFlights article[id*='flightsArticle'] 

    ${btn_detalhes_ida}=            Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.details-bt a span

    showElementsize                 ${btn_detalhes_ida}     btn_detalhes_ida
   
   
   
   
   
    # openDetails                     ${btn_detalhes_ida}     0
    
    # pegar todos os elementos necessários dos voos de ida
    # ${company_ida}=                 Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.compThumb img.visible-desktop
    # ${numero_voo_ida}=              Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.details-bt .checkin-details__flight p
    # ${tipo_voo_ida}=                Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.desk-banners div p[class*=cabin]

    # ${data_hora_partida_ida}=            Get WebElements     css:#firstFlights article[id*='flightsArticle'] .checkin-details__depart .visible-desktop span:nth-child(2)
    # ${data_hora_chegada_ida}=            Get WebElements     css:#firstFlights article[id*='flightsArticle'] .checkin-details__return .visible-desktop span:nth-child(2)

    # # get atribute flt-miles
    # ${valor_milhas_ida}=            Get WebElements     css:#firstFlights article[id*='flightsArticle'] .payment-options .column-miles li.club .flightcb

    # # Atributos: flt-miles e flt-money (R$)
    # ${valor_smilesMoney_ida}=       Get WebElements     css:#firstFlights article[id*='flightsArticle'] .payment-options .column-mandm li.club .flightcb

    # showElementsize                 ${company_ida}                  company_ida
    # showElementsize                 ${numero_voo_ida}               numero_voo_ida
    # showElementsize                 ${tipo_voo_ida}                 tipo_voo_ida
    # showElementsize                 ${data_hora_partida_ida}        data_hora_partida_ida
    # showElementsize                 ${data_hora_chegada_ida}        data_hora_chegada_ida
    # showElementsize                 ${valor_milhas_ida}             valor_milhas_ida
    # showElementsize                 ${valor_smilesMoney_ida}        valor_smilesMoney_ida
    

    # # seção da companhia aérea ---------------------------------------------------
    # log to console      -------------------------------------------------------------------------
    # FOR    ${element}    IN    @{company_ida}
    # ${url}=     Get Element Attribute       ${element}   src
    # # log to console      url: ${url}
    
    # # validação das urls para pegar o nome da compainha
    # ${airfrance}=    Evaluate   "airfrance" in """${url}"""
    # ${qatar}=    Evaluate   "qatar" in """${url}"""
    # ${klm}=    Evaluate   "klm" in """${url}"""
    # ${emirates}=    Evaluate   "emirates" in """${url}"""
    
    # Run Keyword If    '${airfrance}'== 'True'    Run Keywords    airfrance
    # ...    ELSE IF      '${qatar}'== 'True'    Run Keywords    qatar
    # ...    ELSE IF      '${klm}'== 'True'    Run Keywords    klm
    # ...    ELSE IF      '${emirates}'== 'True'    Run Keywords    emirates
    # ...    ELSE         Run Keywords     notClassified
    # END

    # # seção do número do vôo ---------------------------------------------------
    # log to console      -------------------------------------------------------------------------
    # FOR    ${element}    IN    @{numero_voo_ida}
    # ${lines}=       Get Lines Containing String 	${element.text}     Voo
    # log to console      Número do Vôo: ${lines}

    # END

    # # seção do Tipo de vôo ---------------------------------------------------
    # log to console      -------------------------------------------------------------------------
    # FOR    ${element}    IN    @{tipo_voo_ida}
    # # ${lines}=       Get Lines Containing String 	${element.text}     Voo
    # log to console      Tipo de Vôo: ${element.text}

    # END

    # # seção do data e hora de partida ---------------------------------------------------
    # log to console      -------------------------------------------------------------------------
    # FOR    ${elementa}    IN    @{data_hora_partida_ida}
    # Run Keyword If    "${element.text}"!=""       log to console     Data e Hora da Partida: ${element.text}

    # END

    # FOR    ${element}    IN    @{data_hora_chegada_ida}
    # Run Keyword If    "${element.text}"!=""       log to console     Data e Hora da Chegada: ${element.text}

    # END

   # seção do data e hora de partida ---------------------------------------------------
    # log to console      -------------------------------------------------------------------------
    # FOR    ${element}    IN    @{valor_milhas_ida}
    # # Run Keyword If    "${element.text}"!=""       log to console     Data e Hora da Partida: ${element.text}
    # ${valor}=     Get Element Attribute       ${element}   flt-miles
    # log to console      Quantidade de milhas : ${valor}

    # END

    # FOR    ${element}    IN    @{valor_smilesMoney_ida}
    # ${smiles}=     Get Element Attribute       ${element}   flt-miles
    # ${money}=     Get Element Attribute       ${element}   flt-money
    # log to console      Smiles & Money: ${smiles} + R$${money}

    # END
    
    

    
    
    log to console      ----------------------------------------------------------
    log to console      ---------------------- Resultados ------------------------
    ${voos_ida_size}=            Get Length      ${qtde_voos_ida} 
    log to console      Quantidade de vôos: ${voos_ida_size}
    
    # pegar dados dos vôos de IDA:
    Log to console      Lista de Vôos de IDA:
    FOR    ${index}    IN RANGE   ${voos_ida_size}
        log to console      Opção de Vôo de ida Nº ${index+1}
        openDetails         ${btn_detalhes_ida}         ${index}
        ${company_ida}  ${numero_voo_ida}  ${tipo_voo_ida}  ${data_hora_partida_ida}  ${data_hora_chegada_ida}  ${valor_milhas_ida}  ${valor_smilesMoney_ida}        get_elements

        # showElementsize     ${company_ida}                  company_ida
        # showElementsize     ${numero_voo_ida}               numero_voo_ida
        # showElementsize     ${tipo_voo_ida}                 tipo_voo_ida
        # showElementsize     ${data_hora_partida_ida}        data_hora_partida_ida
        # showElementsize     ${data_hora_chegada_ida}        data_hora_chegada_ida
        # showElementsize     ${valor_milhas_ida}             valor_milhas_ida
        # showElementsize     ${valor_smilesMoney_ida}        valor_smilesMoney_ida

        company_name        ${company_ida}              ${index}
        numero_voo          ${numero_voo_ida}           
        tipo_voo            ${tipo_voo_ida}             ${index}
        data_hora_partida   ${data_hora_partida_ida}
        data_hora_chegada   ${data_hora_chegada_ida}
        quantidade_milhas   ${valor_milhas_ida}         ${index}
        milhas_dinheiro     ${valor_smilesMoney_ida}    ${index}
        closeDetails        ${btn_detalhes_ida}         ${index}
        log to console      -------------------------------------------------------------------------
    END

    

    
    
    
    
    # closeDetails        ${btn_detalhes_ida}  0


    log to console      ----------------------------------------------------------


    # validaVoosIda                   ${qtde_voos_ida}
    
    
    # Sleep                           5
    








*** Keywords ***

get_elements
    ${company_ida}=                 Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.compThumb img.visible-desktop
    ${numero_voo_ida}=              Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.details-bt .checkin-details__flight p
    ${tipo_voo_ida}=                Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.desk-banners div p[class*=cabin]
    ${data_hora_partida_ida}=       Get WebElements     css:#firstFlights article[id*='flightsArticle'] .checkin-details__depart .visible-desktop span:nth-child(2)
    ${data_hora_chegada_ida}=       Get WebElements     css:#firstFlights article[id*='flightsArticle'] .checkin-details__return .visible-desktop span:nth-child(2)
    ${valor_milhas_ida}=            Get WebElements     css:#firstFlights article[id*='flightsArticle'] .payment-options .column-miles li.club .flightcb
    ${valor_smilesMoney_ida}=       Get WebElements     css:#firstFlights article[id*='flightsArticle'] .payment-options .column-mandm li.club .flightcb
    
    [return]    ${company_ida}  ${numero_voo_ida}  ${tipo_voo_ida}  ${data_hora_partida_ida}  ${data_hora_chegada_ida}  ${valor_milhas_ida}  ${valor_smilesMoney_ida}

selectDepartureDay
    [Arguments]     ${departureDay}  
    ${elements}=    Get WebElements    //div[@id='ui-datepicker-div']/div[@class='ui-datepicker-group ui-datepicker-group-first']/table/tbody/tr/td[contains(a,'${departureDay}')]
    Click Element   ${elements[0]}

selectArrivalDay
    [Arguments]     ${arrDay}  
    ${elements}=    Get WebElements    //div[@id='ui-datepicker-div']/div[@class='ui-datepicker-group ui-datepicker-group-last']/table/tbody/tr/td[contains(a,'${arrDay}')]
    Click Element   ${elements[0]}

validaVoosIda
    [Arguments]     ${qtde_voos_ida}
    
    ${size}=        Get Length      ${qtde_voos_ida}

    log to console      Tamanho: ${size}

    FOR    ${element}    IN    ${qtde_voos_ida}

        ${url}=     Get Element     ${element}  div.payment-options div.column-miles div.column-header
        log to console      url: ${url.text}

        # ${child_elems}=      Get Parent Webelement       ${element} .miles .club span
        # log to console      get ${element} type
        # log to console      get ${qtde_voos_ida} type
        # ${type_ABC}         Evaluate        type($element)
        # ${type_voos}         Evaluate        type($qtde_voos_ida)
        # log to console      Tipo: ${type_ABC}
        # log to console      Tipo: ${type_voos}

        # log to console      Texto ${child_elems.text}
        # Page should contain image   ${element id}
        # Element should be visible   ${element id}
        
        # log to console      Dia selecionado: ${element.text}
        # Click Element       ${element}
        # Run Keyword If	    """${element.text}""" == """${Firstday}"""	Exit For Loop
    END

showElementsize
    [Arguments]         ${element}      ${name}
    ${size}=            Get Length      ${element} 
    log to console      ${name} : ${size}

openDetails
    [Arguments]         ${btn}  ${index}
    ${element}=     Get From List       ${btn}      ${index}

    Click Element       ${element}

closeDetails
    [Arguments]         ${btn}  ${index}
    ${element}=     Get From List       ${btn}      ${index}

    Click Element       ${element}

airfrance
    log to console      Companhia Aérea: Air France

qatar
    log to console      Companhia Aérea: Qatar

klm
    log to console      Companhia Aérea: KLM

emirates
    log to console      Companhia Aérea: Emirates

notClassified
    log to console      Companhia Aérea: Não Classificada.

company_name
    [Arguments]     ${company_ida}      ${index}  
    ${elementname}=     Get From List       ${company_ida}      ${index}
    ${url}=     Get Element Attribute       ${elementname}   src
    
    # validação das urls para pegar o nome da compainha
    ${airfrance}=    Evaluate   "airfrance" in """${url}"""
    ${qatar}=    Evaluate   "qatar" in """${url}"""
    ${klm}=    Evaluate   "klm" in """${url}"""
    ${emirates}=    Evaluate   "emirates" in """${url}"""
    
    Run Keyword If    '${airfrance}'== 'True'    Run Keywords    airfrance
    ...    ELSE IF      '${qatar}'== 'True'    Run Keywords    qatar
    ...    ELSE IF      '${klm}'== 'True'    Run Keywords    klm
    ...    ELSE IF      '${emirates}'== 'True'    Run Keywords    emirates
    ...    ELSE         Run Keywords     notClassified
    
numero_voo
    [Arguments]     ${numero_voo_ida}
    ${size}=            Get Length      ${numero_voo_ida} 

    ${mensagem}=    Set Variable    Número do Vôo:
    Run Keyword If      ${size}>1       log to console     ** Atenção, essa opção possui conexão **
    FOR    ${element}    IN    @{numero_voo_ida}
        ${lines}=       Get Lines Containing String 	${element.text}     Voo
        log to console      ${mensagem} ${lines}
        ${mensagem}=     Set Variable If    ${size}>1   Número da Conexão:

    END

troca_mensagem
    ${mensagem}=    Set Variable    Número da Conexão:
    [Return] ${mensagem}

tipo_voo
    # seção do Tipo de vôo ---------------------------------------------------
    [Arguments]     ${tipo_voo_ida}   ${index}
    ${element}=     Get From List       ${tipo_voo_ida}       ${index}
    log to console      Tipo de Vôo: ${element.text}

data_hora_partida
    # seção do data e hora de partida ---------------------------------------------------
    [Arguments]     ${data_hora_partida_ida}       
    FOR    ${element}    IN    @{data_hora_partida_ida}
    Run Keyword If    "${element.text}"!=""       log to console     Data e Hora da Partida: ${element.text}
    END

data_hora_chegada
    [Arguments]     ${data_hora_chegada_ida}   
    FOR    ${element}    IN    @{data_hora_chegada_ida}
    Run Keyword If    "${element.text}"!=""       log to console     Data e Hora da Chegada: ${element.text}
    END

quantidade_milhas
    [Arguments]     ${valor_milhas_ida}   ${index}   
    ${element}=     Get From List       ${valor_milhas_ida}      ${index}

    ${valor}=     Get Element Attribute       ${element}   flt-miles
    log to console      Milhas : ${valor}

milhas_dinheiro
    [Arguments]     ${valor_smilesMoney_ida}   ${index}   
    ${element}=     Get From List       ${valor_smilesMoney_ida}      ${index}
    ${smiles}=     Get Element Attribute       ${element}   flt-miles
    ${money}=     Get Element Attribute       ${element}   flt-money
    log to console      Smiles & Money: ${smiles} + R$${money}
