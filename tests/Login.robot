*** Settings ***
Library           SeleniumLibrary
Library           Process
Library           OperatingSystem
Library           XML
Resource          ../resources/Setting.robot

*** Variables ***
${HEADERS}    Accept: text/html

*** Test Cases ***
Sign in page - To verify, Sign in page - Sign in page displays correctly
    [Tags]    Sign in page
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[1]/img

    #Verify Username
    Element Should Be Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/label
    ${txt_username}    Get Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/label
    Should Be Equal    ${txt_username}    Username

    Element Should Be Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/input

    #Verify Password
    Element Should Be Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/label
    ${txt_password}    Get Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/label
    Should Be Equal    ${txt_password}    Password

    Element Should Be Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/div/input

    Sleep    1s

    #Verify Forgot password
    Element Should Be Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[1]/span
    ${txt_forgot_password}    Get Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[1]/span
    Should Be Equal    ${txt_forgot_password}    Forgot password ?

    #Verify Forgot password
    Element Should Be Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[2]
    ${txt_sign_in}    Get Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[2]
    Should Be Equal    ${txt_sign_in}    Sign In

    Close Browser

Sign in page - To verify Username and Password Textfield - Username and Password Textfield are displayed correctly
    [Tags]    Sign in page
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[1]/img

    #Verify Username Textfield
    Element Should Be Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/input
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/input    ${USERNAME}
    Textfield Value Should Be    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/input    admin@local.host

    #Verify Username Textfield
    Element Should Be Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/div/input
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/div/input    ${PASSWORD}
    Textfield Value Should Be    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/div/input    Passw0rd2023


    Close Browser

Sign in page - To verify, Sign in button - Sign in button is worked correctly
    [Tags]    Sign in page
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[1]/img

    #Input username and password
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/input    ${USERNAME}
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/div/input    ${PASSWORD}

    Sleep    1s

    #Click sign-in button
    Click Element    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-header"]/div/div[2]/img
    Location Should Be    http://localhost:5173/

    Close Browser

Sign in page - To verify, Sign in button - Sign in button is worked correctly when input invalid username
    [Tags]    Sign in page
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[1]/img

    #Input password
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/div/input    ${PASSWORD}

    Sleep    1s

    #Click sign-in button
    Click Element    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[2]
    ${txt_invalid_username}    Get Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/small
    Should Be Equal    ${txt_invalid_username}    Please enter a valid username.

    Close Browser

Sign in page - To verify, Sign in button - Sign in button is worked correctly when input invalid password
    [Tags]    Sign in page
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[1]/img

    #Input username
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/input    ${USERNAME}

    Sleep    1s

    #Click sign-in button
    Click Element    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[2]
    ${txt_invalid_password}    Get Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/small
    Should Be Equal    ${txt_invalid_password}    Please enter a valid password.

    Close Browser

Sign in page - To verify, Sign in button - Sign in button is worked correctly when input invalid username and password
    [Tags]    Sign in page
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[1]/img

    Sleep    1s

    #Click sign-in button
    Click Element    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[2]
    ${txt_invalid_username}    Get Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/small
    Should Be Equal    ${txt_invalid_username}    Please enter a valid username.
    ${txt_invalid_password}    Get Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/small
    Should Be Equal    ${txt_invalid_password}    Please enter a valid password.

    Close Browser

Sign in page - To verify, Sign in button - Sign in button is worked correctly when input wrong username or password
    [Tags]    Sign in page
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[1]/img

    #Input wrong username and password
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/input    wrong_username@gmail.com
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/div/input    wrong_password

    Sleep    1s

    #Click sign-in button
    Click Element    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[5]/div/div/div
    ${txt_wrong_username_or_password}    Get Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[5]/div/div/div
    Should Be Equal    ${txt_wrong_username_or_password}    Please enter a valid username or password.

    Close Browser

Sign in page - To verify, Sign in button - Sign in button is worked correctly when there have been more than 5 failed
    [Tags]    Sign in page
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[1]/img

    #Input wrong username and password
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[2]/div/input    username@hotmail.com
    Input Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[3]/div/div/input    password

    Sleep    1s

    #Click sign-in button with 6 failed
    FOR    ${click}    IN RANGE    6
        Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[2]
        Click Element    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[4]/div/button[2]
        Wait Until Element Is Visible    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[5]/div/div/div
    END

    ${txt_blocked}    Get Text    xpath=//*[@id="tmhth-signin"]/div/div/div/div/div[5]/div/div/div
    Should Be Equal    ${txt_blocked}    There have been more than 5 failed login attempts for this account. It is temporarily blocked. Try again after 15 minute or request a new password.

    Close Browser