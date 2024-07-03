*** Settings ***
Library           SeleniumLibrary
Library           XML
Resource          ../resources/Setting.robot

*** Test Cases ***
Side Bar - To verify, Side Bar - Side Bar displays correctly
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Verify Dashboard 
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[1]/button
    ${txt_dashboard}    Get Text    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[1]/button
    Should Be Equal    ${txt_dashboard}    Dashboard

    #Verify KEY Carts
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[2]/button
    ${txt_key_carts}    Get Text    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[2]/button
    Should Be Equal    ${txt_key_carts}    KEY Carts

    #Verify Station and Route
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[3]/button
    ${txt_station_and_route}    Get Text    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[3]/button
    Should Be Equal    ${txt_station_and_route}    Station and Route

    #Verify Users
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[4]/button
    ${txt_users}    Get Text    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[4]/button
    Should Be Equal    ${txt_users}    Users

    #Verify System Setting
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[5]/button
    ${txt_system_setting}    Get Text    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[5]/button
    Should Be Equal    ${txt_system_setting}    System Setting

    #Verify Logs
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[6]/button
    ${txt_logs}    Get Text    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[6]/button
    Should Be Equal    ${txt_logs}    Logs

    Close Browser

Side Bar - To verify, Side Bar button - Side Bar opens and closes correctly
    [Tags]    Side Bar

    Auto login

    #Open side bar
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Close side bar
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Not Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    Close Browser

Side Bar - To verify, Dashboard menu - Dashboard menu works correctly
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click Dashboard menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[1]/button
    Wait Until Element Is Visible    xpath=//*[@id="map-area"]/button

    Location Should Be    http://localhost:5173/

    Close Browser

Side Bar - To verify, Dashboard menu - Dashboard menu works correctly when already in Dashboard page
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click Dashboard menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[1]/button
    Wait Until Element Is Visible    xpath=//*[@id="map-area"]/button

    #Click Dashboard menu again
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[1]/button
    Wait Until Element Is Visible    xpath=//*[@id="map-area"]/button

    Location Should Be    http://localhost:5173/

    Close Browser

Side Bar - To verify, KEY Carts menu - KEY Carts menu works correctly
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click KEY Carts menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[2]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li/button/span
    ${txt_key_carts_page}    Get Text    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li/button/span
    Should Be Equal    ${txt_key_carts_page}    Key Carts

    Location Should Be    http://localhost:5173/keycarts

    Close Browser

Side Bar - To verify, KEY Carts menu - KEY Carts menu works correctly when already in KEY Carts page
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click KEY Carts menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[2]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li/button/span

    #Click KEY Carts menu again
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[2]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li/button/span

    Location Should Be    http://localhost:5173/keycarts

    Close Browser

Side Bar - To verify, Station and Route menu - Station and Route menu works correctly
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click Station and Route menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[3]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    ${txt_station_and_route_page}    Get Text    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    Should Be Equal    ${txt_station_and_route_page}    Station and Route Mapping

    Location Should Be    http://localhost:5173/stationandroute

    Close Browser

Side Bar - To verify, Station and Route menu - Station and Route menu works correctly when already in Station and Route page
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click Station and Route menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[3]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span

    #Click Station and Route menu again
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[3]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span

    Location Should Be    http://localhost:5173/stationandroute

    Close Browser

Side Bar - To verify, Users menu - Users menu works correctly
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click Users menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[4]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    ${txt_users_page}    Get Text    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    Should Be Equal    ${txt_users_page}    Users

    Location Should Be    http://localhost:5173/users

    Close Browser

Side Bar - To verify, Users menu - Users menu works correctly when already in Users page
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click Users menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[4]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span

    #Click Users menu again
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[4]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span

    Location Should Be    http://localhost:5173/users

    Close Browser

Side Bar - To verify, System Setting menu - System Setting menu works correctly
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click System Setting menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[5]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    ${txt_system_setting_page}    Get Text    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    Should Be Equal    ${txt_system_setting_page}    System Setting

    Location Should Be    http://localhost:5173/systemsetting

    Close Browser

Side Bar - To verify, System Setting menu - System Setting menu works correctly when already in System Setting page
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click System Setting menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[5]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span

    #Click System Setting menu again
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[5]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span

    Location Should Be    http://localhost:5173/systemsetting

    Close Browser

Side Bar - To verify, Logs menu - Logs menu works correctly
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click Logs menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[6]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    ${txt_logs_page}    Get Text    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    Should Be Equal    ${txt_logs_page}    Logs

    Location Should Be    http://localhost:5173/logs

    Close Browser

Side Bar - To verify, Logs menu - Logs menu works correctly when already in Logs page
    [Tags]    Side Bar

    #Login and open side bar
    Auto login
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]

    #Click Logs menu
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[6]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span

    #Click Logs menu again
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[6]/button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span

    Location Should Be    http://localhost:5173/logs

    Close Browser