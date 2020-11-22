*** Settings ***
Library     SeleniumLibrary
Library     DateTime 
Library     String
Library     Collections
Library     OperatingSystem

*** Variables ***
${url}              http://www.smiles.com.br

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
    Capture Page Screenshot
    Close Browser

print_relatorio_voos_ida
    [Arguments]         ${qtde_voos_ida}    ${qtde_voos_volta}      ${btn_detalhes_ida}
    write_in_file      -------------------------------------------------------------------------
    write_in_file      ------------------------- Resultados da busca ---------------------------
    ${voos_ida_size}=   Get Length          ${qtde_voos_ida} 
    
    write_in_file      -------------------------------------------------------------------------
    write_in_file                           *** Lista de Vôos de IDA: ***
    write_in_file      -------------------------------------------------------------------------
    write_in_file                        Quantidade de vôos Encontrados: ${voos_ida_size}
    write_in_file      -------------------------------------------------------------------------
    FOR    ${index}     IN RANGE   ${voos_ida_size}
        write_in_file      Opção de Vôo de ida Nº ${index+1}:
        openDetails         ${btn_detalhes_ida}         ${index}
        
        ${company_ida}  ${numero_voo_ida}  ${tipo_voo_ida}  ${data_hora_partida_ida}  ${data_hora_chegada_ida}  ${valor_milhas_ida}  ${valor_smilesMoney_ida}  ${companylogo}       get_elements_ida
   
        # Valida se o thumbnail da companhia existe:        
        checkimage          ${companylogo}              ${index}

        company_name        ${company_ida}              ${index}
        numero_voo          ${numero_voo_ida}           
        tipo_voo            ${tipo_voo_ida}             ${index}
        data_hora_partida   ${data_hora_partida_ida}
        data_hora_chegada   ${data_hora_chegada_ida}
        quantidade_milhas   ${valor_milhas_ida}         ${index}
        milhas_dinheiro     ${valor_smilesMoney_ida}    ${index}
        closeDetails        ${btn_detalhes_ida}         ${index}
        write_in_file      -------------------------------------------------------------------------
    END

print_relatorio_voos_volta
    [Arguments]             ${qtde_voos_ida}        ${qtde_voos_volta}      ${btn_detalhes_volta}
    
  
    ${voos_volta_size}=     Get Length      ${qtde_voos_volta} 
    
    write_in_file      -------------------------------------------------------------------------
    write_in_file                           *** Lista de Vôos de VOLTA: ***
    write_in_file      -------------------------------------------------------------------------
    write_in_file                          Quantidade de vôos Encontrados: ${voos_volta_size}
    write_in_file      -------------------------------------------------------------------------
    FOR    ${index}     IN RANGE   ${voos_volta_size}
        write_in_file      Opção de Vôo de volta Nº ${index+1}:
        openDetails         ${btn_detalhes_volta}         ${index}
        
        ${company_volta}  ${numero_voo_volta}  ${tipo_voo_volta}  ${data_hora_partida_volta}  ${data_hora_chegada_volta}  ${valor_milhas_volta}  ${valor_smilesMoney_volta}  ${companylogo}     get_elements_volta
        
     # Valida se o thumbnail da companhia existe:        
        checkimage          ${companylogo}                ${index}

        company_name        ${company_volta}              ${index}
        numero_voo          ${numero_voo_volta}           
        tipo_voo            ${tipo_voo_volta}             ${index}
        data_hora_partida   ${data_hora_partida_volta}
        data_hora_chegada   ${data_hora_chegada_volta}
        quantidade_milhas   ${valor_milhas_volta}         ${index}
        milhas_dinheiro     ${valor_smilesMoney_volta}    ${index}
        closeDetails        ${btn_detalhes_volta}         ${index}
        write_in_file      -------------------------------------------------------------------------
    END

acess_page
    [Arguments]     ${from}     ${to}       ${dayDeparture}
    Title Should Be                 ${title}
    Click Element                   ${btn_accept_cookies}
    Click Element                   ${buscaVoos}
    Input Text                      ${inputFrom}        ${from}
    Press Keys                      ${inputFrom}        TAB
    Input Text                      ${inputTo}          ${to}
    Press Keys                      ${inputFrom}        TAB
    Click Element                   ${departure}
    selectDepartureDay              ${dayDeparture.day}
    selectArrivalDay                15
    Click Element                   ${btn_Confirmar}
    Click Element                   ${btn_BuscaVoo}
    Capture Page Screenshot
    Wait Until Element Is Visible   ${title_sugerido}

get_elements_ida
    ${company_ida}=                 Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.compThumb img.visible-desktop
    ${numero_voo_ida}=              Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.details-bt .checkin-details__flight p
    ${tipo_voo_ida}=                Get WebElements     css:#firstFlights article[id*='flightsArticle'] div.desk-banners div p[class*=cabin]
    ${data_hora_partida_ida}=       Get WebElements     css:#firstFlights article[id*='flightsArticle'] .checkin-details__depart .visible-desktop span:nth-child(2)
    ${data_hora_chegada_ida}=       Get WebElements     css:#firstFlights article[id*='flightsArticle'] .checkin-details__return .visible-desktop span:nth-child(2)
    ${valor_milhas_ida}=            Get WebElements     css:#firstFlights article[id*='flightsArticle'] .payment-options .column-miles li.club .flightcb
    ${valor_smilesMoney_ida}=       Get WebElements     css:#firstFlights article[id*='flightsArticle'] .payment-options .column-mandm li.club .flightcb
    ${companylogo}                  Get WebElements     css:#firstFlights article[id*='flightsArticle'] .company__thumb

    [return]    ${company_ida}  ${numero_voo_ida}  ${tipo_voo_ida}  ${data_hora_partida_ida}  ${data_hora_chegada_ida}  ${valor_milhas_ida}  ${valor_smilesMoney_ida}  ${companylogo}

get_elements_volta
    ${company_volta}=                 Get WebElements     css:#secondFlights article[id*='flightsArticle'] div.compThumb img.visible-desktop
    ${numero_voo_volta}=              Get WebElements     css:#secondFlights article[id*='flightsArticle'] div.details-bt .checkin-details__flight p
    ${tipo_voo_volta}=                Get WebElements     css:#secondFlights article[id*='flightsArticle'] div.desk-banners div p[class*=cabin]
    ${data_hora_partida_volta}=       Get WebElements     css:#secondFlights article[id*='flightsArticle'] .checkin-details__depart .visible-desktop span:nth-child(2)
    ${data_hora_chegada_volta}=       Get WebElements     css:#secondFlights article[id*='flightsArticle'] .checkin-details__return .visible-desktop span:nth-child(2)
    ${valor_milhas_volta}=            Get WebElements     css:#secondFlights article[id*='flightsArticle'] .payment-options .column-miles li.club .flightcb
    ${valor_smilesMoney_volta}=       Get WebElements     css:#secondFlights article[id*='flightsArticle'] .payment-options .column-mandm li.club .flightcb
    ${companylogo}                    Get WebElements     css:#secondFlights article[id*='flightsArticle'] .company__thumb

    [return]    ${company_volta}  ${numero_voo_volta}  ${tipo_voo_volta}  ${data_hora_partida_volta}  ${data_hora_chegada_volta}  ${valor_milhas_volta}  ${valor_smilesMoney_volta}  ${companylogo}

checkimage
    [Arguments]         ${companylogo}      ${index}  
    ${elementname}=     Get From List       ${companylogo}      ${index}
    Page Should Contain Image   ${elementname}

selectDepartureDay
    [Arguments]     ${departureDay}  
    ${elements}=    Get WebElements    //div[@id='ui-datepicker-div']/div[@class='ui-datepicker-group ui-datepicker-group-first']/table/tbody/tr/td[contains(a,'${departureDay}')]
    Click Element   ${elements[0]}
    
selectArrivalDay
    [Arguments]     ${arrDay}  
    ${elements}=    Get WebElements    //div[@id='ui-datepicker-div']/div[@class='ui-datepicker-group ui-datepicker-group-last']/table/tbody/tr/td[contains(a,'${arrDay}')]
    Click Element   ${elements[0]}
    
validaVoosIda
    [Arguments]         ${qtde_voos_ida}
    ${size}=            Get Length      ${qtde_voos_ida}
    log to console      Tamanho: ${size}
    FOR    ${element}   IN    ${qtde_voos_ida}
        ${url}=         Get Element     ${element}  div.payment-options div.column-miles div.column-header
        # log to console  url: ${url.text}
        write_in_file   url: ${url.text}
    END

showElementsize
    [Arguments]         ${element}      ${name}
    ${size}=            Get Length      ${element} 
    # log to console      ${name} : ${size}
    write_in_file       ${name} : ${size}

openDetails
    [Arguments]         ${btn}          ${index}
    ${element}=         Get From List   ${btn}      ${index}
    Click Element       ${element}

    ${disclaimer}=              Get WebElements     css:.flight-details__disclaimer
    ${disclaimer0}=             Get From List       ${disclaimer}      0
    Scroll Element Into View    ${disclaimer0}
    Capture Page Screenshot

closeDetails
    [Arguments]         ${btn}          ${index}
    ${element}=         Get From List   ${btn}      ${index}
    Click Element       ${element}

airfrance
    write_in_file  Companhia Aérea: Air France

qatar
    write_in_file  Companhia Aérea: Qatar

klm
    write_in_file  Companhia Aérea: KLM

emirates
    write_in_file  Companhia Aérea: Emirates

alitalia
    write_in_file  Companhia Aérea: Alitalia

notClassified
    write_in_file  Companhia Aérea: Não Classificada.

company_name
    [Arguments]         ${company_ida}          ${index}  
    ${elementname}=     Get From List           ${company_ida}      ${index}
    ${url}=             Get Element Attribute   ${elementname}      src
    
    # validação das urls para pegar o nome da compainha
    ${airfrance}=   Evaluate   "airfrance" in """${url}"""
    ${qatar}=       Evaluate   "qatar" in """${url}"""
    ${klm}=         Evaluate   "klm" in """${url}"""
    ${emirates}=    Evaluate   "emirates" in """${url}"""
    ${alitalia}=    Evaluate   "alitalia" in """${url}"""
    
    Run Keyword If    '${airfrance}'== 'True'   Run Keywords    airfrance
    ...    ELSE IF    '${qatar}'== 'True'       Run Keywords    qatar
    ...    ELSE IF    '${klm}'== 'True'         Run Keywords    klm
    ...    ELSE IF    '${emirates}'== 'True'    Run Keywords    emirates
    ...    ELSE IF    '${alitalia}'== 'True'    Run Keywords    alitalia
    ...    ELSE       Run Keywords     notClassified
    
numero_voo
    [Arguments]         ${numero_voo_ida}
    ${size}=            Get Length          ${numero_voo_ida} 

    ${mensagem}=        Set Variable    Número do Vôo:
    Run Keyword If      ${size}>1       log to console     ** Atenção, essa opção possui conexão **
    FOR    ${element}   IN    @{numero_voo_ida}
        ${lines}=       Get Lines Containing String 	${element.text}     Voo
        write_in_file  ${mensagem} ${lines}
        ${mensagem}=    Set Variable If    ${size}>1   Número da Conexão:

    END

troca_mensagem
    ${mensagem}=    Set Variable    Número da Conexão:
    [Return]        ${mensagem}

tipo_voo
    # seção do Tipo de vôo ---------------------------------------------------
    [Arguments]         ${tipo_voo_ida}   ${index}
    ${element}=         Get From List     ${tipo_voo_ida}   ${index}
    write_in_file       Tipo de Vôo: ${element.text}

data_hora_partida
    # seção do data e hora de partida ---------------------------------------------------
    [Arguments]         ${data_hora_partida_ida}       
    FOR    ${element}   IN    @{data_hora_partida_ida}
    Run Keyword If      "${element.text}"!=""       write_in_file  Data e Hora da Partida: ${element.text}
    END

data_hora_chegada
    [Arguments]         ${data_hora_chegada_ida}   
    FOR    ${element}   IN    @{data_hora_chegada_ida}
    Run Keyword If      "${element.text}"!=""       write_in_file  Data e Hora da Chegada: ${element.text}
    END

quantidade_milhas
    [Arguments]     ${valor_milhas_ida}     ${index}   
    ${element}=     Get From List           ${valor_milhas_ida}      ${index}
    ${valor}=       Get Element Attribute   ${element}              flt-miles
    write_in_file   Milhas : ${valor}

milhas_dinheiro
    [Arguments]     ${valor_smilesMoney_ida}    ${index}   
    ${element}=     Get From List               ${valor_smilesMoney_ida}    ${index}
    ${smiles}=      Get Element Attribute       ${element}      flt-miles
    ${money}=       Get Element Attribute       ${element}      flt-money
    write_in_file  Smiles & Money: ${smiles} + R$${money}

write_in_file
  [Arguments]  ${variable}
  log to console    ${variable}
  ${format_variable}    Set Variable    ${variable}\n
  Append To File    ${EXECDIR}/relatorio/${tag}.txt      ${format_variable}
