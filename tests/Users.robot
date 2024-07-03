*** Settings ***
Resource      ../resources/Setting.robot
Library         DatabaseLibrary
Library    XML
Test Setup        Go to Users page
Library    String
Test Teardown    Close Database and Browser

*** Variables ***
${FULLNAME}    ${EMPTY}
${EMAIL}    ${EMPTY}
${ROLE}    ${EMPTY}
${STATUS}    Active
${USERS_COUNT}    0
${USERS}    ${EMPTY}

@{ROLE_OPTION}    Admin    Staff    Viewer
@{STATUS_OPTION}    Active    Inactive
@{DISPLAY}    10    25    50    100
${DISPLAY_AMOUNT}    10

*** Keywords ***
Go to Users page
    Auto login
    Database Connecting

    #Go to Users page
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Sleep    1s
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[4]/button
    Sleep    1s
    
Close Database and Browser
    Disconnect From Database
    Close Browser

# Search by filter 
#     ${users}    Query    SELECT * FROM m_users WHERE
#     Set Global Variable    ${USERS}    ${users}
#     ${users_count}=    Get Length    ${USERS}
#     Set Global Variable    ${USERS_COUNT}    ${users_count}
#     Log To Console    count: ${USERS_COUNT}

*** Test Cases ***
Users Page - Users Page - To verify display of the "Users page" can display correctly.
    [Tags]    Users page

    #System: Display details of "Users page", including:

    #Message "Users".
    Wait Until Element Is Visible    xpath=/html/body/div[1]/section/div[2]/div[1]/ul/li/button/span
    Element Should Be Visible    xpath=/html/body/div[1]/section/div[2]/div[1]/ul/li/button/span
    ${txt_users}    Get Text    xpath=/html/body/div[1]/section/div[2]/div[1]/ul/li/button/span
    Should Be Equal    ${txt_users}    Users

    #Message "Status: "(text from "Status" dropdown in "Filter").
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[1]/span[4]/span
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria"]/div[1]/span[4]/span
    ${txt_status}    Get Text    xpath=//*[@id="tmhth-criteria"]/div[1]/span[4]/span
    Should Be Equal    ${txt_status}    Status : ${STATUS}

    #"Filter" button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    ${txt_filter}    Get Text    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Should Be Equal    ${txt_filter}    Filter

    #"Register User" button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    ${txt_regist}    Get Text    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Should Be Equal    ${txt_regist}    Register User

    #Message "Results" , number of data , message "Rows".
    # Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[1]/div/label
    # Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[1]/div/label
    # ${txt_users_count}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[1]/div/label
    # Should Be Equal    ${txt_users_count}    Results ${USERS_COUNT} Rows

    #Message "Display" with dropdown button.
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[2]/div/label
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[2]/div/label
    ${txt_display}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[2]/div/label
    Should Be Equal    ${txt_display}    Display

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[2]/div

    #System: Display details in user data list table, including:
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div

    #Select all row check box.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]/div

    #Message "Full Name".
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[2]
    ${txt_fullname}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[2]
    Should Be Equal    ${txt_fullname}    Full Name

    #Message "Email".
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[3]
    ${txt_email}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[3]
    Should Be Equal    ${txt_email}    Email

    #Message "Role".
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[4]
    ${txt_role}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[4]
    Should Be Equal    ${txt_role}    Role

    #Message "Status".
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[5]
    ${txt_status}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[5]
    Should Be Equal    ${txt_status}    Status

    #Message "Action".
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[6]
    ${txt_action}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[6]
    Should Be Equal    ${txt_action}    Action

    #Row check box.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div

    #Row user data(Full Name , Email , Role , Status).
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[2]
    ${value_fullname}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[2]
    Should Not Be Empty    ${value_fullname}

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[3]
    ${value_email}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[3]
    Should Not Be Empty    ${value_email}

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[4]
    ${value_role}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[4]
    Should Not Be Empty    ${value_role}

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[5]
    ${value_status}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[5]
    Should Not Be Empty    ${value_status}

    #Delete icon.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[6]/label[1]

    #Edit icon.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[6]/label[2]
    
    #First page button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[1]

    #Back page button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[2]

    #Next page button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()-1]

    #Last page button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    
"Filter" button - "Filter" button and pop-up. - To verify display of pop-up of "Filter" button can display correctly.
    [Tags]    Users page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Message "Filters"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]
    ${txt_filter}    Get Text    xpath=/html/body/div[6]/div/div[1]
    Should Be Equal    ${txt_filter}    Filters

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Message "Full Name" and "Full Name" field
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[1]/div/label
    ${txt_fullname}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[1]/div/label
    # Should Be Equal    ${txt_fullname}    Full Name

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input

    ${value_fullname}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input
    Should Be Equal    ${value_fullname}    ${EMPTY}

    #Message "Email" and "Email" field
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[3]/div/label
    ${txt_email}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[3]/div/label
    Should Be Equal    ${txt_email}    Email

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input

    ${value_email}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input
    Should Be Equal    ${value_email}    ${EMPTY}

    #Message "Role" and dropdown (Admin,Staff,Viewer)
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[1]/div/label
    ${txt_role}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[1]/div/label
    Should Be Equal    ${txt_role}    Role

    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div

    Sleep    1s

    ${value_role}    Get Text    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div
    Should Be Equal    ${value_role}    Select a Role

    #Message "Status" and dropdown (Active, Inactive)
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[3]/div/label
    ${txt_status}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[3]/div/label
    Should Be Equal    ${txt_status}    Status

    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[4]/div

    ${value_status}    Get Text    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[4]/div
    Should Be Equal    ${value_status}    Active

    #"Reset" button.
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]

    #"Search" button.
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]


"Filter" button - "Filter" button and pop-up. - To verify function "X" button from pop-up can work properly.
    [Tags]    Users page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "X" button
    Click Element    xpath=/html/body/div[6]/div/div[1]/div/button
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div 
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

"Filter" button - "Filter" button and pop-up. - To verify function "Reset" button from pop-up can work properly.
    [Tags]    Users page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    Sleep    2s

    #Input data in field.
    #Input "Full Name"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input
    Input Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input    System

    #Input "Email"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input
    Input Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input    local
    
    #Select "Role"
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div
    Click Element    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div/ul/li[1]
    Click Element    xpath=/html/body/div[7]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[7]/div/ul/li[1]

    #Select "Status"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/div/span
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/div/span
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div/ul/li[2]
    Click Element    xpath=/html/body/div[7]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[7]/div/ul/li[2]

    #Click "Reset" button
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[1]

    #Check if Filter pop-up is reset
    ${value_fullname}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input
    Should Be Equal    ${value_fullname}    ${EMPTY}

    ${value_email}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input
    Should Be Equal    ${value_email}    ${EMPTY}

    ${value_role}    Get Text    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div
    Should Be Equal    ${value_role}    Select a Role

    ${value_status}    Get Text    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[4]/div
    Should Be Equal    ${value_status}    Active


"Filter" button - "Filter" button and pop-up. - To verify function "Search" button from pop-up can work properly.
    [Tags]    Users page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    Sleep    2s

    #Input data in field.
    #Input "Full Name"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input
    Input Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input    System

    #Input "Email"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input
    Input Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input    local
    
    #Select "Role"
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div
    Click Element    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div/ul/li[2]
    Click Element    xpath=/html/body/div[7]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[7]/div/ul/li[2]

    #Select "Status"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/div/span
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/div/span
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div/ul/li[1]
    Click Element    xpath=/html/body/div[7]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[7]/div/ul/li[1]

    #Get search value
    ${value_fullname}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input
    ${value_email}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input
    ${value_role}    Get Text    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div
    ${value_status}    Get Text    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[4]/div

    # Click "Search" button
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[2]
    Set Global Variable    ${FULLNAME}    ${value_fullname}
    Set Global Variable    ${EMAIL}    ${value_email}
    Set Global Variable    ${ROLE}    ${value_role}
    Set Global Variable    ${STATUS}    ${value_status}
    # Search by filter

    Log To Console    message: ${FULLNAME} ${EMAIL} ${ROLE} ${STATUS}

    # #Check search result
    # Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table
    # ${txt_logs_count}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[1]/div/label
    # Should Be Equal    ${txt_logs_count}    Results ${LOGS_COUNT} Rows


"Filter" button - "Full Name" field in the "Filter" pop-up.
    [Tags]    Users page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Input full name in "Full Name" field
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input
    Input Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input    System

    ${value_fullname}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/input
    Should Be Equal    ${value_fullname}    System

"Filter" button - "Email" field in the "Filter" pop-up.
    [Tags]    Users page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Input full email in "Email" field
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input
    Input Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input    local

    ${value_email}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/input
    Should Be Equal    ${value_email}    local

"Filter" button - "Role" dropdown in the "Filter" pop-up.
    [Tags]    Users page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    Sleep    1s

    #Check Role all options
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div
    Click Element    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div/ul
    FOR    ${index}    IN RANGE    1    4
        ${txt_role_options}    Get Text    xpath=/html/body/div[7]/div/ul/li[${index}]
        Should Be Equal    ${txt_role_options}    ${ROLE_OPTION}[${index-1}]
    END

    #Select new role in "Role" field.
    Click Element    xpath=/html/body/div[7]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[7]/div/ul
    ${value_role}    Get Text    xpath=/html/body/div[6]/div/div[2]/form/div/div[2]/div[2]/div
    Should Be Equal    ${value_role}    ${ROLE_OPTION}[0]

"Filter" button - "Status" dropdown in the "Filter" pop-up.
    [Tags]    Users page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    Sleep    1s

    #Check Status all options
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/div/span
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/div/span
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div/ul
    FOR    ${index}    IN RANGE    1    3
        ${txt_status_options}    Get Text    xpath=/html/body/div[7]/div/ul/li[${index}]
        Should Be Equal    ${txt_status_options}    ${STATUS_OPTION}[${index-1}]
    END

    #Select new role in "Status" field.
    Click Element    xpath=/html/body/div[7]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[7]/div/ul
    ${value_status}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/div/span
    Should Be Equal    ${value_status}    ${STATUS_OPTION}[0]

"Register User" button - "Register User" button. - To verify function of "Register User" button can work properly.
    [Tags]    Users page

    #Click "Register User" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label
    Location Should Be    http://localhost:5173/users/register


User Registration Page - User Registertration Page. - To verify display of the User Registration page can display correctly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #System: Display details of "User Registration page", including:
    #Message "Users > Registration".
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[1]/button
    ${txt_users}    Get Text    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[1]/button
    Should Be Equal    ${txt_users}    Users

    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[2]

    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[3]/button
    ${txt_registration}    Get Text    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[3]/button
    Should Be Equal    ${txt_registration}    Registration

    #Message "User Registration".
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label
    ${txt_users_registration}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[1]/label
    Should Be Equal    ${txt_users_registration}    User Registration

    #Message "First Name*" and "First Name" field.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[1]/div[1]/div/label
    ${txt_firstname}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[1]/div[1]/div/label
    Should Be Equal    ${txt_firstname}    First Name

    ${field_firstname}    Get Element Attribute    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[1]/div[1]/div/label    class
    Should Contain    ${field_firstname}    required

    Element Should Be Visible    xpath=//*[@id="firstname"]

    #Message "Last Name*" and "Last Name" field.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[1]/div[3]/div/label
    ${txt_lastname}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[1]/div[3]/div/label
    Should Be Equal    ${txt_lastname}    Last Name

    ${field_lastname}    Get Element Attribute    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[1]/div[3]/div/label    class
    Should Contain    ${field_lastname}    required

    Element Should Be Visible    xpath=//*[@id="lastname"]

    #Message "Email*" and "Email" field.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[1]/div/label
    ${txt_email}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[1]/div/label
    Should Be Equal    ${txt_email}    Email

    ${field_email}    Get Element Attribute    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[1]/div/label    class
    Should Contain    ${field_email}    required

    Element Should Be Visible    xpath=//*[@id="email_address"]

    #Message "Role*"  and dropdown (Admin,Staff,Viewer).
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[3]/div/label
    ${txt_role}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[3]/div/label
    Should Be Equal    ${txt_role}    Role

    ${dropdown_role}    Get Element Attribute    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[3]/div/label    class
    Should Contain    ${dropdown_role}    required

    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]


    #Message "Status*" and Active/Inactive toggle button.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[3]/div[1]/div/label
    ${txt_status}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[3]/div[1]/div/label
    Should Be Equal    ${txt_status}    Status

    ${toggle_status}    Get Element Attribute    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[3]/div[1]/div/label    class
    Should Contain    ${toggle_status}    required

    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[3]/div[2]/div


    #"Reset" button.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[1]

    #"Registrater" button.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]


User Registration Page - Message "Users_Registration". - To verify the function of message "Users_Registration" can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Click the message "Users" in the message "Users > Registration"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[1]/button
    Click Element    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[1]/button
    Sleep    2s
    Wait Until Element Is Visible    xpath=/html/body/div[1]/section/div[2]/div[1]/ul/li/button/span
    Location Should Be    http://localhost:5173/users

User Registration Page - "Firstname" field. - To verify display of "Firstname" field can display correctly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input firstname in the "Firstname" field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    ${value_firstname}    Get Value    xpath=//*[@id="firstname"]
    Should Be Equal    ${value_firstname}    testuser



User Registration Page - "Lastname" field. - To verify display of "Lastname" field can display correctly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input lastname in the "lastname" field.
    Input Text    xpath=//*[@id="lastname"]    testuser
    ${value_lastname}    Get Value    xpath=//*[@id="lastname"]
    Should Be Equal    ${value_lastname}    testuser



User Registration Page - "Email" field. - To verify display of "Email" field can display correctly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input Email in the "Email" field.
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    ${value_email}    Get Value    xpath=//*[@id="email_address"]
    Should Be Equal    ${value_email}    testuser@gmail.com



User Registration Page - "Role" dropdown. - To verify display and function of the "Role" dropdown can display correctly and work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Check Role all options
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    FOR    ${index}    IN RANGE    1    4
        ${txt_role_options}    Get Text    xpath=/html/body/div[6]/div/ul/li[${index}]
        Should Be Equal    ${txt_role_options}    ${ROLE_OPTION}[${index-1}]
    END

    #Select new role in "Role" field.
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    ${value_role}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Should Be Equal    ${value_role}    ${ROLE_OPTION}[0]

User Registration Page - "Status" toggle button. - To verify display and function of "Status" toggle button can display correctly and work properly. (In status "Inactive")
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #In status "Inactive"
    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked
    Should Be Equal    ${toggle_status}    false

    #Click "Status" toggle button
    Click Element    xpath=//*[@id="user_status"]
    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked
    Should Be Equal    ${toggle_status}    true



User Registration Page - "Status" toggle button. - To verify display and function of "Status" toggle button can display correctly and work properly. (In status "Active")
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #In status "Active"
    Click Element    xpath=//*[@id="user_status"]
    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked
    Should Be Equal    ${toggle_status}    true

    #Click "Status" toggle button
    Click Element    xpath=//*[@id="user_status"]
    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked
    Should Be Equal    ${toggle_status}    false



User Registration Page - "Reset" button. - To verify display and function of "Reset" button can display correctly and work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Reset" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    #Message "Confirmation"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/span
    ${txt_confirmation_title}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_confirmation_title}    Confirmation

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Alert icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[1]

    #Message "Are you sure you want to reset change?"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[2]
    ${txt_confirmation}    Get Text    xpath=/html/body/div[6]/div/div[2]/span[2]
    Should Be Equal    ${txt_confirmation}    Are you sure you want to reset change?

    #"No" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    ${txt_btn_no}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    Should Be Equal    ${txt_btn_no}    No

    #"Yes" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    ${txt_btn_yes}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    Should Be Equal    ${txt_btn_yes}    Yes


User Registration Page - "Reset" button. - To verify function of "X" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Reset" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "X" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[1]/div/button

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

User Registration Page - "Reset" button. - To verify function of "No" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Reset" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "No" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[1]

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User Registration Page - "Reset" button. - To verify function of "Yes" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Reset" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "Yes" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[2]

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

    #System wil remove all text in field, including:
    #"First Name" field.
    ${value_firstname}    Get Value    xpath=//*[@id="firstname"]
    Should Be Equal    ${value_firstname}    ${EMPTY}

    #"Last Name" field.
    ${value_lastname}    Get Value    xpath=//*[@id="lastname"]
    Should Be Equal    ${value_lastname}    ${EMPTY}

    #"Email" field.
    ${value_email}    Get Value    xpath=//*[@id="email_address"]
    Should Be Equal    ${value_email}    ${EMPTY}

    #"Role" dropdown.
    ${value_role}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Should Be Equal    ${value_role}    Select a Role

    #Toggle "Status"
    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked
    Should Be Equal    ${toggle_status}    false


User Registration Page - "Register" button. - To verify display and function of "Register" button can display correctly and work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    #Message "Confirmation"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/span
    ${txt_confirmation_title}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_confirmation_title}    Confirmation

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Alert icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[1]

    #Message "Are you sure you want to register user?"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[2]
    ${txt_confirmation}    Get Text    xpath=/html/body/div[6]/div/div[2]/span[2]
    Should Be Equal    ${txt_confirmation}    Are you sure you want to register user?

    #"No" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    ${txt_btn_no}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    Should Be Equal    ${txt_btn_no}    No

    #"Yes" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    ${txt_btn_yes}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    Should Be Equal    ${txt_btn_yes}    Yes


User Registration Page - "Register" button. - To verify function of "X" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "X" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[1]/div/button

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

User Registration Page - "Register" button. - To verify function of "No" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "No" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[1]

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

User Registration Page - "Register" button. - To verify function of "Yes" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[3]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "Yes" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[2]

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

    Sleep    5s

    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[2]/div/div/div
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[2]/div/div/div
    ${txt_successful}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[2]/div/div/div
    Should Be Equal    ${txt_successful}    Account name "testuser@gmail.com" has been register completed.

User Registration Page - "Register" button. (Register with email that already been registered.) - To verify display of "Register" button in case input all the required field with email that already been registered can display correctly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    #Message "Confirmation"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/span
    ${txt_confirmation_title}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_confirmation_title}    Confirmation

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Alert icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[1]

    #Message "Are you sure you want to register user?"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[2]
    ${txt_confirmation}    Get Text    xpath=/html/body/div[6]/div/div[2]/span[2]
    Should Be Equal    ${txt_confirmation}    Are you sure you want to register user?

    #"No" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    ${txt_btn_no}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    Should Be Equal    ${txt_btn_no}    No

    #"Yes" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    ${txt_btn_yes}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    Should Be Equal    ${txt_btn_yes}    Yes

User Registration Page - "Register" button. (Register with email that already been registered.) - To verify function of "X" button" from "Confirmation" pop-up in case register with email that already been registered can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "X" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[1]/div/button

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

User Registration Page - "Register" button. (Register with email that already been registered.) - To verify function of "No" button from "Confirmation" pop-up in case register with email that already been registered can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "No" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[1]

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

User Registration Page - "Register" button. (Register with email that already been registered.) - To verify function of "Yes" button from "Confirmation" pop-up in case register with email that already been registered can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    testuser
    Input Text    xpath=//*[@id="lastname"]    testuser
    Input Text    xpath=//*[@id="email_address"]    testuser@gmail.com
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[3]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=//*[@id="user_status"]

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "Yes" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[2]

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

    Sleep    5s

    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[2]/div/div/div
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[2]/div/div/div
    ${txt_successful}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[2]/div/div/div
    Should Be Equal    ${txt_successful}    The 'testuser@gmail.com' is already used by another user.

User Registration Page - "Register" button. (Without filling the required field.) - To verify display and function of "Register" button in case register without filling the required field can display correctly and work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    #Message "Confirmation"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/span
    ${txt_confirmation_title}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_confirmation_title}    Confirmation

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Alert icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[1]

    #Message "Are you sure you want to register user?"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[2]
    ${txt_confirmation}    Get Text    xpath=/html/body/div[6]/div/div[2]/span[2]
    Should Be Equal    ${txt_confirmation}    Are you sure you want to register user?

    #"No" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    ${txt_btn_no}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    Should Be Equal    ${txt_btn_no}    No

    #"Yes" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    ${txt_btn_yes}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    Should Be Equal    ${txt_btn_yes}    Yes

User Registration Page - "Register" button. (Without filling the required field.) - To verify function of "X" button from "Confirmation" pop-up in case without filling the required field can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "X" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[1]/div/button

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

User Registration Page - "Register" button. (Without filling the required field.) - To verify function of "No" button from "Confirmation" pop-up in case without filling the required field can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "No" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[1]

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

User Registration Page - "Register" button. (Without filling the required field.) - To verify function of "Yes" button from "Confirmation" pop-up in case without filling the required field can work properly.
    [Tags]    Users page

    #Go to User Registration page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-registration"]/div[1]/label

    #Click "Register" button
    Click Element    xpath=//*[@id="tmhth-user-registration"]/div[3]/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Yes" button in "Comfirmation" pop-up.
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[2]

    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

    #error message under required fields
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[1]/div[2]/small
    ${txt_error_firstname}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[1]/div[2]/small
    Should Be Equal    ${txt_error_firstname}    The firstname is required.
    
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[1]/div[4]/small
    ${txt_error_lastname}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[1]/div[4]/small
    Should Be Equal    ${txt_error_lastname}    The lastname is required.
    
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[2]/small
    ${txt_error_email}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[2]/small
    Should Be Equal    ${txt_error_email}    Please enter a valid email address. (mail@mail.com)
    
    Element Should Be Visible    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]/small
    ${txt_error_role}    Get Text    xpath=//*[@id="tmhth-user-registration"]/div[2]/form/div[2]/div[4]/small
    Should Be Equal    ${txt_error_role}    The role is required.


"Display" dropdown - "Display" dropdown. - To verify display of "Display" dropdown can display correctly.
    [Tags]    Users page

    #Check Display all options
    Wait Until Element Is Visible    xpath=/html/body/div[1]/section/div/div[2]/section/div[1]/div/div[2]/div/div
    Click Element    xpath=/html/body/div[1]/section/div/div[2]/section/div[1]/div/div[2]/div/div
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    FOR    ${index}    IN RANGE    1    5
        ${txt_display_options}    Get Text    xpath=/html/body/div[6]/div/ul/li[${index}]
        Should Be Equal    ${txt_display_options}    ${DISPLAY}[${index-1}]
    END

    #Select Display number.
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Visible    xpath=/html/body/div[1]/section/div/div[2]/section/div[1]/div/div[2]/div/div
    ${value_display}    Get Text    xpath=/html/body/div[1]/section/div/div[2]/section/div[1]/div/div[2]/div/div
    Should Be Equal    ${value_display}    ${DISPLAY}[1]

    #Display logs data list table according to the number of data that the user selected.

User data list table. - "Select all row" checkbox. - To verify display and function of "Select all row" checkbox can display correctly and work properly.
    [Tags]    Users page

    # Click select all row check box
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]/div/div
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]/div/div/input
    ${all_rows_status}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]/div/div/input    aria-label
    Should Contain    ${all_rows_status}    selected

    # Display the correct icon in the all checkbox, and select all rows in the user data list table.
    FOR    ${row}    IN RANGE    1    ${DISPLAY_AMOUNT}+1
        ${row_status}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[${row}]/td[1]/div/input    aria-label
        Should Contain    ${row_status}    Selected
      
        ${next_row_exists}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[${row}+1]
        Exit For Loop If    ${next_row_exists} == False
    END
    

User data list table. - "Select all row" checkbox. - To verify display and function of "Unselect all row" checkbox can display correctly and work properly.
    [Tags]    Users page

    # When all rows are selected
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]/div
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]/div/div/input
    ${all_rows_status}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]/div/div/input    aria-label
    Should Contain    ${all_rows_status}    selected

    # Click select all row check box to unselect all rows
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]/div
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]/div/div/input
    ${all_rows_status}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]/div/div/input    aria-label
    Should Contain    ${all_rows_status}    unselected

    # Display the blank checkbox, and unselect all rows in the user data list table.
    FOR    ${row}    IN RANGE    1    ${DISPLAY_AMOUNT}+1
        ${row_status}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[${row}]/td[1]/div/input    aria-label
        Should Contain    ${row_status}    Unselected
      
        ${next_row_exists}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[${row}+1]
        Exit For Loop If    ${next_row_exists} == False
    END


User data list table. - "Select Rows" checkbox. - To verify display and function of "Select Row" checkbox can display correctly and work properly.
    [Tags]    Users page

    # Click select row check box
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div/input
    ${row_status}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div/input    aria-label
    Should Contain    ${row_status}    Selected


User data list table. - "Select Rows" checkbox. - To verify display and function of "Unselect Row" checkbox can display correctly and work properly.
    [Tags]    Users page

    # When all row is selected
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div/input
    ${all_rows_status}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div/input    aria-label
    Should Contain    ${all_rows_status}    Selected

    # Click select row check box to unselect row
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div/input
    ${all_rows_status}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]/div/input    aria-label
    Should Contain    ${all_rows_status}    Unselected

User data list table. - "Delete" icon. - To verify display and function of "Delete" icon can display correctly and work properly.
    [Tags]    Users page

    #Click "Delete" icon.
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[1]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[1]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    #Message "Delete Confirmation"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/span
    ${txt_confirmation_title}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_confirmation_title}    Delete Confirmation

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Alert icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[1]

    #Message "Are you sure you want to register user?"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[2]
    ${txt_confirmation}    Get Text    xpath=/html/body/div[6]/div/div[2]/span[2]
    Should Be Equal    ${txt_confirmation}    Are you sure you want to delete this record?

    #"No" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    ${txt_btn_no}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    Should Be Equal    ${txt_btn_no}    No

    #"Yes" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    ${txt_btn_yes}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    Should Be Equal    ${txt_btn_yes}    Yes

User data list table. - "Delete" icon. - To verify function of "X" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Click "Delete" icon.
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[1]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    # Click "X" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[1]/div/button
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

User data list table. - "Delete" icon. - To verify function of "No" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page
    
    # Click "Delete" icon.
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[1]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    # Click "No" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User data list table. - "Delete" icon. - To verify function of "Yes" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    # Click "Delete" icon.
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[1]
    ${user_email}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[3]
    Log To Console    email: ${user_email}

    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    # Click "Yes" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

    # Display pop-up message "Please wait until the current process is finished."
    # Sleep    3s
    # Wait Until Element Is Visible    xpath=/div/div
    # Element Should Be Visible    xpath=/div/div
    # ${txt_message}    Get Text    xpath=/div/div
    # Should Be Equal    ${txt_message}    Please wait until the current process is finished.
    # Wait Until Element Is Not Visible    xpath=/div/div

    Sleep    6s

    ${isdeleted_status}    Query    SELECT isdeleted FROM m_users WHERE username = '${user_email}'
    ${txt_isdeleted_status}    Convert To String    ${isdeleted_status}
    Log To Console    isdeleted_user: ${txt_isdeleted_status}
    Should Be Equal    ${txt_isdeleted_status}    []

User data list table. - "Edit" icon. - To verify function of "Edit" icon can work properly.
    [Tags]    Users page

    # Click "Edit" icon.
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    
    #System will redirect to the "User Edit page"
    # Sleep    3s
    # Wait Until Element Is Visible    xpath=/html/body/div[1]/section/div[2]/div[1]/ul/li/button/span
    # Location Should Be    http://localhost:5173/users/*
    
    #In process loading page will display loading bar.
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/section/div/div/div/h3
    ${txt_loading}=    Get Text    xpath=//*[@id="tmhth-user-edit"]/section/div/div/div/h3
    Should Be Equal    ${txt_loading}    Loading ...

User data list table. - "First Page" button. - To verify function of "First Page" button can work properly.
    [Tags]    Users page

    #Go to Last page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Click Button   xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    #Click "First Page" button
    Click Element    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[1]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    ${pagination_current_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[3]    class
    Should Contain    ${pagination_current_page}    p-active
    ${txt_page_number}    Get Text    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[3]
    Should Be Equal    ${txt_page_number}    1


User data list table. - "First Page" button. - To verify function of "First Page" button in case already in first page of user data list table can work properly.
    [Tags]    Users page

    #Check "First Page" button is disabled
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[1]

    ${txt_page_number}    Get Text    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[3]
    Should Be Equal    ${txt_page_number}    1

    ${button_first_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[1]    class
    Should Contain    ${button_first_page}    p-disabled


User data list table. - "Back Page" button. - To verify function of "Back Page" button can work properly.
    [Tags]    Users page

    #Go to Last page
    Sleep    3s
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Click Button   xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    #Click "Back Page" button
    Click Element    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    ${pagination_old_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()-2]    class
    Should Not Contain    ${pagination_old_page}    p-active
    ${pagination_current_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()-3]    class
    Should Contain    ${pagination_current_page}    p-active


User data list table. - "Back Page" button. - To verify function of "Back Page" button in case already in first page of user data list table can work properly.
    [Tags]    Users page
    
    #At First page
    Sleep    1s
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    #Check "Back Page" button is disabled
    ${button_back_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[2]    class
    Should Contain    ${button_back_page}    p-disabled


User data list table. - "Page Number" button. - To verify "Page Number" button can display correctly and work properly.
    [Tags]    Users page
    
    #Click "Page Number" button at page 2
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[4]

    ${txt_page_number}    Get Text    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[4]
    Should Be Equal    ${txt_page_number}    2
    
    Click Element    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[4]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    ${pagination_current_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[4]    class
    Should Contain    ${pagination_current_page}    p-active


User data list table. - "Next Page" button. - To verify function of "Next Page" button can work properly.
    [Tags]    Users page
    
    #At First page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    
    #Click "Next Page" button
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()-1]
    Click Element    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()-1]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    ${pagination_old_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[3]    class
    Should Not Contain    ${pagination_old_page}    p-active
    ${pagination_current_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[4]    class
    Should Contain    ${pagination_current_page}    p-active


User data list table. - "Next Page" button. - To verify function of "Next Page" button in case already in last page of user data list table can work properly.
    [Tags]    Users page

    #Go to Last page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Click Button   xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    #Check "Next Page" button is disabled
    ${button_next_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()-1]    class
    Should Contain    ${button_next_page}    p-disabled


User data list table. - "Last Page" button. - To verify function of "Last Page" button can work properly.
    [Tags]    Users page

    #Click "Last Page" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Click Button   xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    ${pagination_current_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()-2]    class
    Should Contain    ${pagination_current_page}    p-active


User data list table. - "Last Page" button. - To verify function of "Last Page" button in case already in last page of user list table can work properly.
    [Tags]    Users page

    #Go to Last page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Click Button   xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    #Check "Last Page" button is disabled
    ${button_last_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]    class
    Should Contain    ${button_last_page}    p-disabled

User Edit Page - User Edit page. - To verify display of "User Edit page" can display correctly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    ${txt_fullname}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[2]
    @{user_fullname}=    Split String    ${txt_fullname}    ${SPACE}
    ${user_firstname}=    Set Variable    ${user_fullname}[0]
    ${user_lastname}=      Set Variable    ${user_fullname}[1]
    
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #System: Display details of "User Edit page", including:
    #Message "Users > Edit [(Firstname , Lastname)]".
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[1]/button
    ${txt_users}    Get Text    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[1]/button
    Should Be Equal    ${txt_users}    Users

    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[2]

    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[3]/button
    ${txt_registration}    Get Text    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[3]/button
    Should Be Equal    ${txt_registration}    Edit [${user_firstname} ${user_lastname}]

    #Message "User Edit".
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[1]/label
    ${txt_users_registration}    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[1]/label
    Should Be Equal    ${txt_users_registration}    User Edit

    #Message "First Name*" and "First Name" field.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[1]/div[1]/div/label
    ${txt_firstname}    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[1]/div[1]/div/label
    Should Be Equal    ${txt_firstname}    First Name

    ${field_firstname}    Get Element Attribute    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[1]/div[1]/div/label    class
    Should Contain    ${field_firstname}    required

    Element Should Be Visible    xpath=//*[@id="firstname"]

    #Message "Last Name*" and "Last Name" field.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[1]/div[3]/div/label
    ${txt_lastname}    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[1]/div[3]/div/label
    Should Be Equal    ${txt_lastname}    Last Name

    ${field_lastname}    Get Element Attribute    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[1]/div[3]/div/label    class
    Should Contain    ${field_lastname}    required

    Element Should Be Visible    xpath=//*[@id="lastname"]

    #Message "Email*" and "Email" field.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[2]/div[1]/div/label
    ${txt_email}    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[2]/div[1]/div/label
    Should Be Equal    ${txt_email}    Email

    ${field_email}    Get Element Attribute    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[2]/div[1]/div/label    class
    Should Contain    ${field_email}    required

    Element Should Be Visible    xpath=//*[@id="email_address"]

    #Message "Role*"  and dropdown (Admin,Staff,Viewer).
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[2]/div[3]/div/label
    ${txt_role}    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[2]/div[3]/div/label
    Should Be Equal    ${txt_role}    Role

    ${dropdown_role}    Get Element Attribute    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[2]/div[3]/div/label    class
    Should Contain    ${dropdown_role}    required

    Element Should Be Visible    xpath=//*[@id="user_role"]


    #Message "Status*" and Active/Inactive toggle button.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[3]/div[1]/div/label
    ${txt_status}    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[3]/div[1]/div/label
    Should Be Equal    ${txt_status}    Status

    ${toggle_status}    Get Element Attribute    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[3]/div[1]/div/label    class
    Should Contain    ${toggle_status}    required

    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[3]/div[2]/div

    #"Reset Password" button.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[1]/button

    #"Reset" button.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[1]

    #"Save" button.
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]


User Edit Page - Message "Users > Edit[Fullname]" - To verify function of message "Users > Edit[Fullname]" can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Click the message "Users" in the message "Users > Edit[Fullname]"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[1]/button
    Click Element    xpath=//*[@id="tmhth-body"]/div[2]/div[1]/ul/li[1]/button
    Sleep    2s
    Wait Until Element Is Visible    xpath=/html/body/div[1]/section/div[2]/div[1]/ul/li/button/span
    Location Should Be    http://localhost:5173/users


User Edit Page - "Firstname" field. - To verify display of "Firstname" field can display correctly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    ${txt_fullname}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[2]
    @{user_fullname}=    Split String    ${txt_fullname}    ${SPACE}
    ${user_firstname}=    Set Variable    ${user_fullname}[0]

    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Display auto firstname from the original data before editing in the "Firstname" field.
    ${value_firstname}    Get Value    xpath=//*[@id="firstname"]
    Should Be Equal    ${value_firstname}    ${user_firstname}

    #Change firstname in the field
    Input Text    xpath=//*[@id="firstname"]    editFirstname
    ${value_firstname}    Get Value    xpath=//*[@id="firstname"]
    Should Be Equal    ${value_firstname}    editFirstname


User Edit Page - "Lastname" field. - To verify display of "Lastname" field can display correctly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    ${txt_fullname}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[2]
    @{user_fullname}=    Split String    ${txt_fullname}    ${SPACE}
    ${user_lastname}=    Set Variable    ${user_fullname}[1]

    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    #Display auto lastname from the original data before editing in the "lastname" field.
    ${value_lastname}    Get Value    xpath=//*[@id="lastname"]
    Should Be Equal    ${value_lastname}    ${user_lastname}

    #Input lastname in the "lastname" field.
    Input Text    xpath=//*[@id="lastname"]    editLastname
    ${value_lastname}    Get Value    xpath=//*[@id="lastname"]
    Should Be Equal    ${value_lastname}    editLastname


User Edit Page - "Email" field. - To verify display of "Email" field can display correctly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    ${user_email}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[3]

    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Display auto Email from the original data before editing in the "Email" field.
    ${value_email}    Get Value    xpath=//*[@id="email_address"]
    Should Be Equal    ${value_email}    ${user_email}

    #Input Email in the "Email" field.
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    ${value_email}    Get Value    xpath=//*[@id="email_address"]
    Should Be Equal    ${value_email}    editEmail@gmail.com

User Edit Page - "Role" dropdown. - To verify display and function of the "Role" dropdown can display correctly and work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    ${user_role}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[4]

    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Display auto Role from the original data before editing in the "Role" dropdown.
    Wait Until Element Is Visible    xpath=//*[@id="user_role"]
    ${value_role}    Get Text    xpath=//*[@id="user_role"]
    Should Be Equal    ${value_role}    ${user_role}

    #Select new role in "Role" dropdown.
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    ${value_role}    Get Text    xpath=//*[@id="user_role"]
    Should Be Equal    ${value_role}    ${ROLE_OPTION}[0]

User Edit Page - "Status" toggle button. - To verify display of "Status" toggle button can display correctly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    ${user_status}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[5]

    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Display auto "Status" from the original data before editing.
    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked
    Run Keyword If    "${toggle_status}" == "true"    Should Be Equal    ${user_status}    Active
    Run Keyword If    "${toggle_status}" == "false"    Should Be Equal    ${user_status}    Inactive

User Edit Page - "Status" toggle button. - To verify display and function of "Status" toggle button can display correctly and work properly. (In status "Inactive")
    [Tags]    Users page

    
    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    ${user_status}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[5]
    
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked

    #In status "Active"
    Run Keyword If    "${toggle_status}" == "false"    Click Element    xpath=//*[@id="user_status"]
    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked
    Should Be Equal    ${toggle_status}    true
    
    #Click "Status" toggle button
    Click Element    xpath=//*[@id="user_status"]
    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked
    Should Be Equal    ${toggle_status}    false

User Edit Page - "Status" toggle button. - To verify display and function of "Status" toggle button can display correctly and work properly. (In status "Active")
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    ${user_status}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[5]
    
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked

    #In status "Inactive"
    Run Keyword If    "${toggle_status}" == "true"    Click Element    xpath=//*[@id="user_status"]
    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked
    Should Be Equal    ${toggle_status}    false
    
    #Click "Status" toggle button
    Click Element    xpath=//*[@id="user_status"]
    ${toggle_status}    Get Element Attribute    xpath=//*[@id="user_status"]    aria-checked
    Should Be Equal    ${toggle_status}    true

User Edit Page - "Reset Password" button. - To verify display and function of "Reset Password" button can display correctly and work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Click "Reset Password" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[1]/button

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    #Message "Confirmation"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/span
    ${txt_confirmation_title}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_confirmation_title}    Confirmation

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Alert icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[1]

    #Message "Are you sure you want to reset change?"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[2]
    ${txt_confirmation}    Get Text    xpath=/html/body/div[6]/div/div[2]/span[2]
    Should Be Equal    ${txt_confirmation}    Are you sure you want to reset change?

    #"No" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    ${txt_btn_no}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    Should Be Equal    ${txt_btn_no}    No

    #"Yes" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    ${txt_btn_yes}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    Should Be Equal    ${txt_btn_yes}    Yes


User Edit Page - "Reset Password" button. - To verify function of "X" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Click "Reset Password" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[1]/button

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "X" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[1]/div/button
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User Edit Page - "Reset Password" button. - To verify function of "No" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Click "Reset Password" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[1]/button

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "No" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

User Edit Page - "Reset Password" button. - To verify function of "Yes" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Click "Reset Password" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[1]/button

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "Yes" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

    # Display message "We have e-mailed account password reset link."
    Sleep    3s
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[2]/div/div/div
    ${txt_email_reset_password}=    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[2]/div/div/div
    Should Be Equal    ${txt_email_reset_password}    We have e-mailed account password reset link.

User Edit Page - "Reset" button. - To verify display and function of "Reset" button can display correctly and work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    ${user_email}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[3]
    Log To Console    email: ${user_email}
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    editFirstname
    ${value_firstname}    Get Value    xpath=//*[@id="firstname"]
    Input Text    xpath=//*[@id="lastname"]    editLastname
    ${value_lastname}    Get Value    xpath=//*[@id="lastname"]
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    ${value_email}    Get Value    xpath=//*[@id="email_address"]
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul
    ${value_role}    Get Text    xpath=//*[@id="user_role"]

    #Click "Reset" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[1]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    #Message "Confirmation"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/span
    ${txt_confirmation_title}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_confirmation_title}    Confirmation

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Alert icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[1]

    #Message "Are you sure you want to reset change?"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[2]
    ${txt_confirmation}    Get Text    xpath=/html/body/div[6]/div/div[2]/span[2]
    Should Be Equal    ${txt_confirmation}    Are you sure you want to reset change?

    #"No" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    ${txt_btn_no}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    Should Be Equal    ${txt_btn_no}    No

    #"Yes" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    ${txt_btn_yes}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    Should Be Equal    ${txt_btn_yes}    Yes


User Edit Page - "Reset" button. - To verify function of "X" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    editFirstname
    Input Text    xpath=//*[@id="lastname"]    editLastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Reset" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[1]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "X" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[1]/div/button
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User Edit Page - "Reset" button. - To verify function of "No" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    editFirstname
    Input Text    xpath=//*[@id="lastname"]    editLastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Reset" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[1]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "No" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User Edit Page - "Reset" button. - To verify function of "Yes" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    ${value_firstname}    Get Value    xpath=//*[@id="firstname"]
    ${value_lastname}    Get Value    xpath=//*[@id="lastname"]
    ${value_email}    Get Value    xpath=//*[@id="email_address"]
    ${value_role}    Get Text    xpath=//*[@id="user_role"]

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    editFirstname
    Input Text    xpath=//*[@id="lastname"]    editLastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Reset" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[1]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "Yes" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

    #System will roll back data before editing in fields.
    ${current_firstname}    Get Value    xpath=//*[@id="firstname"]
    Should Be Equal    ${current_firstname}    ${value_firstname}
    ${current_lastname}    Get Value    xpath=//*[@id="lastname"]
    Should Be Equal    ${current_lastname}    ${value_lastname}
    ${current_email}    Get Value    xpath=//*[@id="email_address"]
    Should Be Equal    ${current_email}    ${value_email}
    ${current_role}    Get Text    xpath=//*[@id="user_role"]
    Should Be Equal    ${current_role}    ${value_role}
    

User Edit Page - "Save" button. - To verify display and function of "Save" button can display correctly and work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    editFirstname
    Input Text    xpath=//*[@id="lastname"]    editLastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    #Message "Confirmation"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/span
    ${txt_confirmation_title}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_confirmation_title}    Confirmation

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Alert icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[1]

    #Message "Are you sure you want to save change?"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[2]
    ${txt_confirmation}    Get Text    xpath=/html/body/div[6]/div/div[2]/span[2]
    Should Be Equal    ${txt_confirmation}    Are you sure you want to save change?

    #"No" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    ${txt_btn_no}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    Should Be Equal    ${txt_btn_no}    No

    #"Yes" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    ${txt_btn_yes}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    Should Be Equal    ${txt_btn_yes}    Yes


User Edit Page - "Save" button. - To verify function of "X" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    editFirstname
    Input Text    xpath=//*[@id="lastname"]    editLastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "X" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[1]/div/button
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User Edit Page - "Save" button. - To verify function of "No" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    editFirstname
    Input Text    xpath=//*[@id="lastname"]    editLastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "No" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User Edit Page - "Save" button. - To verify function of "Yes" button from "Confirmation" pop-up can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    editFirstname
    Input Text    xpath=//*[@id="lastname"]    editLastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "Yes" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

    # Display message "Account details have been saved."
    Sleep    3s
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[2]/div/div/div
    ${txt_user_save}=    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[2]/div/div/div
    Should Be Equal    ${txt_user_save}    Account details have been saved.


User Edit Page - "Save" button. (Edit with email that already been registered.) - To verify display and function of "Save" button in case input all the required field with email that already been registered can display correctly and work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    ${value_firstname}    Get Value    xpath=//*[@id="firstname"]
    ${value_lastname}    Get Value    xpath=//*[@id="lastname"]
    ${value_email}    Get Value    xpath=//*[@id="email_address"]
    ${value_role}    Get Text    xpath=//*[@id="user_role"]

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    edit2Firstname
    Input Text    xpath=//*[@id="lastname"]    edit2Lastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    #Message "Confirmation"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/span
    ${txt_confirmation_title}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_confirmation_title}    Confirmation

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Alert icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[1]

    #Message "Are you sure you want to reset change?"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[2]
    ${txt_confirmation}    Get Text    xpath=/html/body/div[6]/div/div[2]/span[2]
    Should Be Equal    ${txt_confirmation}    Are you sure you want to save change?

    #"No" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    ${txt_btn_no}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    Should Be Equal    ${txt_btn_no}    No

    #"Yes" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    ${txt_btn_yes}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    Should Be Equal    ${txt_btn_yes}    Yes


User Edit Page - "Save" button. (Edit with email that already been registered.) - To verify function of "X" button" from "Confirmation" pop-up in case register with email that already been registered can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    edit2Firstname
    Input Text    xpath=//*[@id="lastname"]    edit2Lastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "X" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[1]/div/button
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User Edit Page - "Save" button. (Edit with email that already been registered.) - To verify function of "No" button from "Confirmation" pop-up in case register with email that already been registered can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    edit2Firstname
    Input Text    xpath=//*[@id="lastname"]    edit2Lastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "No" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User Edit Page - "Save" button. (Edit with email that already been registered.) - To verify function of "Yes" button from "Confirmation" pop-up in case register with email that already been registered can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    ${value_firstname}    Get Value    xpath=//*[@id="firstname"]
    ${value_lastname}    Get Value    xpath=//*[@id="lastname"]
    ${value_email}    Get Value    xpath=//*[@id="email_address"]
    ${value_role}    Get Text    xpath=//*[@id="user_role"]

    #Input data in all field.
    Input Text    xpath=//*[@id="firstname"]    edit2Firstname
    Input Text    xpath=//*[@id="lastname"]    edit2Lastname
    Input Text    xpath=//*[@id="email_address"]    editEmail@gmail.com
    ${edit_email}    Get Value    xpath=//*[@id="email_address"]
    Click Element    xpath=//*[@id="user_role"]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/ul
    Click Element    xpath=/html/body/div[6]/div/ul/li[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div/ul

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "Yes" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

    # Display message "The '${edit_email}' is already used by another user."
    Sleep    3s
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[2]/div/div/div
    ${txt_email_used}=    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[2]/div/div/div
    Should Be Equal    ${txt_email_used}    The '${edit_email}' is already used by another user.

    #Display loading bar
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/section/div/div/div/h3
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/section/div/div/div/h3
    Wait Until Element Is Not Visible    xpath=//*[@id="tmhth-user-edit"]/section/div/div/div/h3

    #Display original data
    ${current_firstname}    Get Value    xpath=//*[@id="firstname"]
    Should Be Equal    ${current_firstname}    ${value_firstname}
    ${current_lastname}    Get Value    xpath=//*[@id="lastname"]
    Should Be Equal    ${current_lastname}    ${value_lastname}
    ${current_email}    Get Value    xpath=//*[@id="email_address"]
    Should Be Equal    ${current_email}    ${value_email}
    ${current_role}    Get Text    xpath=//*[@id="user_role"]
    Should Be Equal    ${current_role}    ${value_role}



User Edit Page - "Save" button. (Without filling the required field.) - To verify display and function of "Save" button in case without filling the required field can display correctly and work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    #clear data in required fields.
    Click Element    xpath=//*[@id="firstname"]
    Press Keys    xpath=//*[@id="firstname"]    CTRL+a+BACKSPACE
    Click Element    xpath=//*[@id="lastname"]
    Press Keys    xpath=//*[@id="lastname"]    CTRL+a+BACKSPACE
    Click Element    xpath=//*[@id="email_address"]
    Press Keys    xpath=//*[@id="email_address"]    CTRL+a+BACKSPACE

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    #Message "Confirmation"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/span
    ${txt_confirmation_title}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_confirmation_title}    Confirmation

    #"X" button
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Alert icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[1]

    #Message "Are you sure you want to save change?"
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/span[2]
    ${txt_confirmation}    Get Text    xpath=/html/body/div[6]/div/div[2]/span[2]
    Should Be Equal    ${txt_confirmation}    Are you sure you want to save change?

    #"No" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    ${txt_btn_no}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[1]/span[2]
    Should Be Equal    ${txt_btn_no}    No

    #"Yes" button with icon
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[1]
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    ${txt_btn_yes}    Get Text    xpath=/html/body/div[6]/div/div[3]/button[2]/span[2]
    Should Be Equal    ${txt_btn_yes}    Yes


User Edit Page - "Save" button. (Without filling the required field.) - To verify function of "X" button from "Confirmation" pop-up in case without filling the required field can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    #clear data in required fields.
    Click Element    xpath=//*[@id="firstname"]
    Press Keys    xpath=//*[@id="firstname"]    CTRL+a+BACKSPACE
    Click Element    xpath=//*[@id="lastname"]
    Press Keys    xpath=//*[@id="lastname"]    CTRL+a+BACKSPACE
    Click Element    xpath=//*[@id="email_address"]
    Press Keys    xpath=//*[@id="email_address"]    CTRL+a+BACKSPACE

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "X" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[1]/div/button
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User Edit Page - "Save" button. (Without filling the required field.) - To verify function of "No" button from "Confirmation" pop-up in case without filling the required field can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    #clear data in required fields.
    Click Element    xpath=//*[@id="firstname"]
    Press Keys    xpath=//*[@id="firstname"]    CTRL+a+BACKSPACE
    Click Element    xpath=//*[@id="lastname"]
    Press Keys    xpath=//*[@id="lastname"]    CTRL+a+BACKSPACE
    Click Element    xpath=//*[@id="email_address"]
    Press Keys    xpath=//*[@id="email_address"]    CTRL+a+BACKSPACE

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "No" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


User Edit Page - "Save" button. (Without filling the required field.) - To verify function of "Yes" button from "Confirmation" pop-up in case without filling the required field can work properly.
    [Tags]    Users page

    #Go to User Edit page
    Sleep    6s
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[10]/td[6]/label[2]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]
    
    #clear data in required fields.
    Click Element    xpath=//*[@id="firstname"]
    Press Keys    xpath=//*[@id="firstname"]    CTRL+a+BACKSPACE
    Click Element    xpath=//*[@id="lastname"]
    Press Keys    xpath=//*[@id="lastname"]    CTRL+a+BACKSPACE
    Click Element    xpath=//*[@id="email_address"]
    Press Keys    xpath=//*[@id="email_address"]    CTRL+a+BACKSPACE

    #Click "Save" button
    Click Element    xpath=//*[@id="tmhth-user-edit"]/div[3]/div[1]/div/div[2]/button[2]

    #Confirmation pop-up
    Element Should Be Visible    xpath=/html/body/div[6]/div

    # Click "Yes" button in "Comfirmation" pop-up.
    Click Button    xpath=/html/body/div[6]/div/div[3]/button[2]
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

    #error message under required fields
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[1]/div[2]/small
    ${txt_error_firstname}    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[1]/div[2]/small
    Should Be Equal    ${txt_error_firstname}    The firstname is required.
    
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[1]/div[4]/small
    ${txt_error_lastname}    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[1]/div[4]/small
    Should Be Equal    ${txt_error_lastname}    The lastname is required.
    
    Element Should Be Visible    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[2]/div[2]/small
    ${txt_error_email}    Get Text    xpath=//*[@id="tmhth-user-edit"]/div[2]/form/div[2]/div[2]/small
    Should Be Equal    ${txt_error_email}    Please enter a valid email address. (mail@mail.com)


