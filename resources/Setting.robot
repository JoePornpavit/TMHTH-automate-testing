*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem

*** Keywords ***
Auto login

    #Open Browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button 

    #Input username
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/input    ${USERNAME}
    Textfield Value Should Be    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/input    admin@local.host
    
    #Input password
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/div/input    ${PASSWORD}
    Textfield Value Should Be    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/div/input     ${PASSWORD}

    Sleep    5s

    #Click sign-in button
    Click Element    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[2]
    Sleep    5s
    Wait Until Element Is Visible   xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Location Should Be    http://localhost:5173/

Database Connecting
    Connect To Database    psycopg2    ${DB_NAME}    ${DB_USERNAME}    ${DB_PASSWORD}    ${DB_HOST}    ${DB_PORT}    connect_timeout=30

*** Variables ***
${USERNAME}    admin@local.host
${PASSWORD}    Passw0rd2023
${URL}         http://localhost:5173/signin
${BROWSER}     Edge
${EMAIL}       pornpavit-t@technobrave.asia
${DB_NAME}         tmhth_keycart_test_1
${DB_USERNAME}        postgres
${DB_PASSWORD}        W3aCKPG2UyLJwnXZ
${DB_HOST}            13.215.238.17
${DB_PORT}            6790

