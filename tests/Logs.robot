*** Settings ***
Resource      ../resources/Setting.robot
Library         DatabaseLibrary
Library         DateTime
Library         String
Library        Collections
Library        XML
Test Setup        Go to Logs page and set initial value
Test Teardown    Close Database and Browser

*** Variables ***
${FROM_DATE}    ${EMPTY}
${TO_DATE}    ${EMPTY}
${LOGTYPE}    OPERATION
${KEYWORD}    ${EMPTY}
${LOGS_COUNT}    0
${LOGS}    ${EMPTY}

${Download_Directory}    C:/Users/DELL/Downloads

&{MONTHS}    Jan=January    Feb=February    Mar=March    Apr=April    May=May    Jun=June    Jul=July    Aug=August    Sep=September    Oct=October    Nov=November    Dec=December
@{LOGTYPE_OPTIONS}    ALL    ERROR    INFO    OPERATION    ACCESS
@{DISPLAY}    10    25    50    100

*** Keywords ***
Go to Logs page and set initial value
    Auto login

    #Set initial value
    Database Connecting
    ${from_date}    Get Current Date    UTC    + 7 hours - 7 days
    Set Global Variable    ${FROM_DATE}    ${from_date}
    ${to_date}    Get Current Date    UTC    + 7 hours
    Set Global Variable    ${TO_DATE}    ${to_date}
    Search by filter

    #Go to Logs page
    Click Element    xpath=//*[@id="tmhth-header"]/div/div[1]/i
    Sleep    1s
    Click Element    xpath=//*[@id="tmhth-body"]/div[1]/div/ul[1]/li[6]/button
    Sleep    1s
    
Close Database and Browser
    Disconnect From Database
    Close Browser

# No Keyword
Search by filter 
    ${logs}    Query    SELECT * FROM t_logs WHERE logtimestamp BETWEEN '${FROM_DATE}' AND '${TO_DATE}' AND logtype = '${LOGTYPE}' 
    Set Global Variable    ${LOGS}    ${logs}
    ${logs_count}=    Get Length    ${LOGS}
    Set Global Variable    ${LOGS_COUNT}    ${logs_count}
    Log To Console    count: ${LOGS_COUNT}

Convert Month Name
    [Arguments]    ${short_month}
    ${full_month}    Get From Dictionary    ${MONTHS}    ${short_month}
    [Return]    ${full_month}

*** Test Cases ***
Logs page - Logs page - To verify display of "Logs page" can display correctly.    #WIP
    [Tags]    Logs page

    #System: Display details Logs page, including:

    #Message "Logs"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    Element Should Be Visible    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    ${txt_logs}    Get Text    xpath=//*[@id="tmhth-body"]/div[2]/div/ul/li/button/span
    Should Be Equal    ${txt_logs}    Logs

    #Message "From Date: 7 days ago from current date and current time"
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria"]/div[1]/span[1]/span/span
    ${txt_from_date}    Get Text    xpath=//*[@id="tmhth-criteria"]/div[1]/span[1]/span/span
    ${from_date}    Convert Date    ${FROM_DATE}    result_format=%b, %d %Y %H:%M
    Should Be Equal    ${txt_from_date}    From Date : ${from_date}

    #Message "To Date: Current date and time"
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria"]/div[1]/span[2]/span/span
    ${txt_current_date}    Get Text    xpath=//*[@id="tmhth-criteria"]/div[1]/span[2]/span/span
    ${to_date}    Convert Date    ${TO_DATE}    result_format=%b, %d %Y %H:%M
    Should Be Equal    ${txt_current_date}    To Date : ${to_date}

    #Message "Type: OPERATION"
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria"]/div[1]/span[3]/span/span
    ${txt_def_type}    Get Text    xpath=//*[@id="tmhth-criteria"]/div[1]/span[3]/span/span
    Should Be Equal    ${txt_def_type}    Type : OPERATION

    #"Filter" button
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    ${txt_filter}    Get Text    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Should Be Equal    ${txt_filter}    Filter

    #"Export (CSV)" button
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    ${txt_export}    Get Text    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Should Be Equal    ${txt_export}    Export CSV

    #Message "Results" , number of data , message "Rows"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[1]/div/label
    # Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[1]/div/label
    # ${txt_logs_count}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[1]/div/label
    # Should Be Equal    ${txt_logs_count}    Results ${LOGS_COUNT} Rows

    #Message "Display" with dropdown button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[2]/div/label
    ${txt_display}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[2]/div/label
    Should Be Equal    ${txt_display}    Display

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]

    #System: Display details in "Logs" data list table, including:
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div

    #Select all row check box

    #Message "Datetime"
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]
    ${txt_datetime}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[1]
    Should Be Equal    ${txt_datetime}    Datetime

    #Message "Type"
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[2]
    ${txt_type}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[2]
    Should Be Equal    ${txt_type}    Type

    #Message "Message"
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[3]
    ${txt_message}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[3]
    Should Be Equal    ${txt_message}    Message

    #Message "Action"
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[4]
    ${txt_action}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/thead/tr/th[4]
    Should Be Equal    ${txt_action}    Action

    #Row check box

    #Row logs data (Datetime , Type , Message)
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]
    ${txt_datetime_row}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[1]
    Should Not Be Empty    ${txt_datetime_row}

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[2]
    ${txt_type_row}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[2]
    Should Not Be Empty    ${txt_type_row}

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[3]
    ${txt_message_row}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[3]
    Should Not Be Empty    ${txt_message_row}

    #"Action" icon.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[4]/label/i

    #First page button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[1]

    #Back page button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[2]

    #Next page button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()-1]

    #Last page button.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]

"Filter" button - "Filter" button and pop-up. - To verify display of pop-up of "Filter" button can display correctly.
    [Tags]    Logs page

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

    #Message "From Date" , "From Date field, auto current date and time and calendar icon
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[1]/div/label
    ${txt_from_date}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[1]/div/label
    Should Be Equal    ${txt_from_date}    From Date
    
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/input
    ${value_from_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/input
    ${from_date}=    Convert Date    ${FROM_DATE}    result_format=%Y-%m-%d %H:%M
    Should Be Equal    ${value_from_date}    ${from_date}

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button

    #Message "To Date" , "From Date field, auto current date and time and calendar icon
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[3]/div/label
    ${txt_to_date}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[3]/div/label
    Should Be Equal    ${txt_to_date}    To Date
    
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/input
    ${value_to_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/input
    ${to_date}=    Convert Date    ${TO_DATE}    result_format=%Y-%m-%d %H:%M
    Should Be Equal    ${value_to_date}    ${to_date}

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button

    #Message "Type" and dropdown (ALL,ERROR,INFO,OPEARATION,ACCESS)
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[1]/div/label
    ${txt_type}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[1]/div/label
    Should Be Equal    ${txt_type}    Type

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div

    ${value_type}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div
    Should Be Equal    ${value_type}    OPERATION

    #Message "Keyword" and "Keyword" field.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[3]/div/label
    ${txt_keyword}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[3]/div/label
    Should Be Equal    ${txt_keyword}    Keyword

    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input

    ${value_keyword}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input
    Should Be Equal    ${value_keyword}    ${EMPTY}

    #"Reset" button.
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[1]

    #"Search" button.
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[3]/button[2]


"Filter" button - "Filter" button and pop-up. - To verify function "X" button from pop-up can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div   

    #Click "X" button
    Click Element    xpath=/html/body/div[6]/div/div[1]/div/button
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div 
    Element Should Not Be Visible    xpath=/html/body/div[6]/div


"Filter" button - "Filter" button and pop-up. - To verify function "Reset" button from pop-up can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Input data in field.
    #Select "From Date"
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button
    Wait Until Element Is Visible    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[3]/td[7]/span
    Click Element    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[3]/td[7]/span
    Wait Until Element Is Not Visible    xpath=//table[@class="p-datepicker-calendar"]

    #Select "To Date"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Wait Until Element Is Visible    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[4]/td[7]/span
    Click Element    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[4]/td[7]/span
    Wait Until Element Is Not Visible    xpath=//table[@class="p-datepicker-calendar"]

    #Select "Type"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div/span
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div/ul/li[1]
    Click Element    xpath=/html/body/div[7]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[7]/div/ul/li[1]

    #Input "Keyword"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input
    Input Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input    Search

    #Click "Reset" button
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/div[3]/button[1]
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[1]

    #Check if Filter pop-up is reset
    ${value_from_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/input
    ${from_date}=    Convert Date    ${FROM_DATE}    result_format=%Y-%m-%d %H:%M
    Should Be Equal    ${value_from_date}    ${from_date}

    ${value_to_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/input
    ${to_date}=    Convert Date    ${TO_DATE}    result_format=%Y-%m-%d %H:%M
    Should Be Equal    ${value_to_date}    ${to_date}

    ${value_type}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div
    Should Be Equal    ${value_type}    OPERATION

    ${value_keyword}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input
    Should Be Equal    ${value_keyword}    ${EMPTY}

"Filter" button - "Filter" button and pop-up. - To verify function "Search" button from pop-up can work properly.    #WIP
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Input data in field.
    #Select "From Date"
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button
    Wait Until Element Is Visible    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[3]/td[7]/span
    Click Element    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[3]/td[7]/span
    Wait Until Element Is Not Visible    xpath=//table[@class="p-datepicker-calendar"]

    #Select "To Date"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Wait Until Element Is Visible    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[4]/td[7]/span
    Click Element    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[4]/td[7]/span
    Wait Until Element Is Not Visible    xpath=//table[@class="p-datepicker-calendar"]

    #Select "Type"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div/span
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div/ul/li[1]
    Click Element    xpath=/html/body/div[7]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[7]/div/ul/li[1]

    #Input "Keyword"
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input
    # Input Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input    Search

    #Get search value
    ${value_from_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/input
    ${value_to_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/input
    ${value_type}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div
    # ${value_keyword}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input

    # Click "Search" button
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div/div[3]/button[2]
    Click Element    xpath=/html/body/div[6]/div/div[3]/button[2]
    Set Global Variable    ${FROM_DATE}    ${value_from_date}
    Set Global Variable    ${TO_DATE}    ${value_to_date}
    Set Global Variable    ${TYPE}    ${value_type}
    Search by filter
    # Set Global Variable    ${KEYWORD}    ${value_keyword}

    #Check search result
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table
    ${txt_logs_count}    Get Text    xpath=//*[@id="tmhth-criteria-result"]/div[1]/div/div[1]/div/label
    Should Be Equal    ${txt_logs_count}    Results ${LOGS_COUNT} Rows

"Filter" button - "From Date" field in the "Filter" pop-up. - To verify display of the "From Date" field can display correctly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Display auto "From Date" 7 days ago from current date and current time in the "From Date" field.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/input
    ${value_from_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/input
    ${from_date}=    Convert Date    ${FROM_DATE}    result_format=%Y-%m-%d %H:%M
    Should Be Equal    ${value_from_date}    ${from_date}

"Filter" button - "From Date" field in the "Filter" pop-up. - To verify function "Calendar" icon in "From Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "Calendar" icon in "From Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]

    #Select date and time.
    #Select time
    Click Element    xpath=/html/body/div[7]/div[2]/div[1]/button[2]
    ${selected_time}    Get Text    xpath=/html/body/div[7]/div[2]
    ${selected_time}=    Replace String    ${selected_time}    \n    ${EMPTY}

    #Select date
    ${selected_month_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div[1]/div
    ${txt_date}    Get Text    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[3]/td[7]/span
    ${selected_date}    Set Variable    ${txt_date}${selected_month_year}
    Click Element    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[3]/td[7]/span
    Wait Until Element Is Not Visible    xpath=//table[@class="p-datepicker-calendar"]

    #Check selected date and time result
    ${selected_from_date}    Convert Date    ${selected_date} ${selected_time}    date_format=%d%B%Y %H:%M    result_format=%Y-%m-%d %H:%M
    ${value_from_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/input
    Should Be Equal    ${value_from_date}    ${selected_from_date}

"Filter" button - "From Date" field in the "Filter" pop-up. - To verify function select month from "Calendar" icon in "From Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "From Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    ${txt_selected_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div[1]/div/button[2]

    #Click on "month"
    Click Element    xpath=/html/body/div[7]/div[1]/div/div[1]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${txt_current_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div/button
    Should Be Equal    ${txt_selected_year}    ${txt_current_year}

    #Click "Back" button
    Click Element    xpath=/html/body/div[7]/div[1]/div/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${num_current_year}=    Convert To Integer    ${txt_current_year}
    ${txt_previous_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div/button
    ${num_previous_year}=    Convert To Integer    ${txt_previous_year}
    Should Be Equal    ${num_previous_year}    ${num_current_year-1}

    ${txt_current_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div/button

    #Click "Next" button
    Click Element    xpath=/html/body/div[7]/div[1]/div/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${num_current_year}=    Convert To Integer    ${txt_current_year}
    ${txt_next_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div/button
    ${num_next_year}=    Convert To Integer    ${txt_next_year}
    Should Be Equal    ${num_next_year}    ${num_current_year+1}

    #Select month
    ${txt_current_month}   Get Text    xpath=/html/body/div[7]/div[2]/span[1]
    Click Element    xpath=/html/body/div[7]/div[2]/span[1]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]
    ${txt_current_month}    Convert Month Name    ${txt_current_month}
    ${txt_selected_month}   Get Text    xpath=/html/body/div[7]/div[1]/div/div[1]/div/button[1]
    Should Be Equal    ${txt_current_month}    ${txt_selected_month}

"Filter" button - "From Date" field in the "Filter" pop-up. - To verify function select year from "Calendar" icon in "From Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "From Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]
    
    ${txt_selected_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div[1]/div/button[2]
    ${num_selected_year}=    Convert To Integer    ${txt_selected_year}
    ${num_current_year}    Set Variable    ${num_selected_year}

    #Click on "year"
    Click Element    xpath=/html/body/div[7]/div[1]/div/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${txt_current_decade}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div
    ${txt_current_decade_st}    ${txt_current_decade_ed}    Split String    ${txt_current_decade}    -
    ${num_current_decade_st}=    Convert To Integer    ${txt_current_decade_st}
    ${num_current_decade_ed}=    Convert To Integer    ${txt_current_decade_ed}
    Should Be Equal    ${num_current_decade_st}    ${${num_current_year} - (${num_current_year} % 10)}
    Should Be Equal    ${num_current_decade_ed}    ${${num_current_year} - (${num_current_year} % 10) + 9}

    #Click "Back" button
    Click Element    xpath=/html/body/div[7]/div[1]/div/div/button[1]
    ${num_current_year}    Set Variable    ${num_current_year-10}
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${txt_current_decade}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div
    ${txt_current_decade_st}    ${txt_current_decade_ed}    Split String    ${txt_current_decade}    -
    ${num_current_decade_st}=    Convert To Integer    ${txt_current_decade_st}
    ${num_current_decade_ed}=    Convert To Integer    ${txt_current_decade_ed}
    Should Be Equal    ${num_current_decade_st}    ${${num_current_year} - (${num_current_year} % 10)}
    Should Be Equal    ${num_current_decade_ed}    ${${num_current_year} - (${num_current_year} % 10) + 9}

    #Click "Next" button
    Click Element    xpath=/html/body/div[7]/div[1]/div/div/button[2]
    ${num_current_year}    Set Variable    ${num_current_year+10}
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${txt_current_decade}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div
    ${txt_current_decade_st}    ${txt_current_decade_ed}    Split String    ${txt_current_decade}    -
    ${num_current_decade_st}=    Convert To Integer    ${txt_current_decade_st}
    ${num_current_decade_ed}=    Convert To Integer    ${txt_current_decade_ed}
    Should Be Equal    ${num_current_decade_st}    ${${num_current_year} - (${num_current_year} % 10)}
    Should Be Equal    ${num_current_decade_ed}    ${${num_current_year} - (${num_current_year} % 10) + 9}

    #Select year
    ${txt_current_year}   Get Text    xpath=/html/body/div[7]/div[2]/span[1]
    Click Element    xpath=/html/body/div[7]/div[2]/span[1]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${txt_selected_year}   Get Text    xpath=/html/body/div[7]/div[1]/div/div/div/button
    Should Be Equal    ${txt_current_year}    ${txt_selected_year}

"Filter" button - "From Date" field in the "Filter" pop-up. - To verify function select hour from "Calendar" icon in "From Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "From Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    ${txt_hour}    Get Text    xpath=/html/body/div[7]/div[2]/div[1]/span
    ${num_hour}=    Convert To Integer    ${txt_hour}

    #Click increse hour.
    Click Element    xpath=/html/body/div[7]/div[2]/div[1]/button[1]
    ${txt_new_hour}    Get Text    xpath=/html/body/div[7]/div[2]/div[1]/span
    ${num_new_hour}=    Convert To Integer    ${txt_new_hour}
    Should Be Equal    ${num_new_hour}    ${${num_hour+1}%60}

    ${num_hour}    Set Variable    ${${num_hour+1}%60}

    #Click decrese hour.
    Click Element    xpath=/html/body/div[7]/div[2]/div[1]/button[2]
    ${txt_new_hour}    Get Text    xpath=/html/body/div[7]/div[2]/div[1]/span
    ${num_new_hour}=    Convert To Integer    ${txt_new_hour}
    Should Be Equal    ${num_new_hour}    ${${num_hour-1}%60}

"Filter" button - "From Date" field in the "Filter" pop-up. - To verify function select minute from "Calendar" icon in "From Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "From Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    ${txt_minute}    Get Text    xpath=/html/body/div[7]/div[2]/div[3]/span
    ${num_minute}=    Convert To Integer    ${txt_minute}

    #Click increse minute.
    Click Element    xpath=/html/body/div[7]/div[2]/div[3]/button[1]
    ${txt_new_minute}    Get Text    xpath=/html/body/div[7]/div[2]/div[3]/span
    ${num_new_minute}=    Convert To Integer    ${txt_new_minute}
    Should Be Equal    ${num_new_minute}    ${${num_minute+1}%60}

    ${num_minute}    Set Variable    ${${num_minute+1}%60}

    #Click decrese minute.
    Click Element    xpath=/html/body/div[7]/div[2]/div[3]/button[2]
    ${txt_new_minute}    Get Text    xpath=/html/body/div[7]/div[2]/div[3]/span
    ${num_new_minute}=    Convert To Integer    ${txt_new_minute}
    Should Be Equal    ${num_new_minute}    ${${num_minute-1}%60}

"Filter" button - "From Date" field in the "Filter" pop-up. - To verify function "Today" button in "From Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "From Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    #Click "Today" button.
    Click Element    xpath=/html/body/div[7]/div[3]/button[1]
    ${value_from_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/input
    ${from_date}=    Get Current Date    UTC    + 7 hours    result_format=%Y-%m-%d %H:%M
    Set Global Variable    ${FROM_DATE}    ${from_date}
    Should Be Equal    ${value_from_date}    ${FROM_DATE}

"Filter" button - "From Date" field in the "Filter" pop-up. - To verify function "Clear" button in "From Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "From Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    # Select date and time.
    #Select time
    Click Element    xpath=/html/body/div[7]/div[2]/div[1]/button[2]

    #Select date
    Click Element    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[3]/td[7]/span
    Wait Until Element Is Not Visible    xpath=//table[@class="p-datepicker-calendar"]

    #Click "Calendar" icon in "From Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    #Click "Clear" button.
    Click Element    xpath=/html/body/div[7]/div[3]/button[2]

    #Check selected date and time result
    ${value_from_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[2]/span/input
    Should Be Equal    ${value_from_date}    ${EMPTY}

"Filter" button - "To Date" field in the "Filter" pop-up. - To verify display of the "To Date" field can display correctly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Display auto "To Date" from current date and current time in the "To Date" field.
    Element Should Be Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/input
    ${value_to_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/input
    ${to_date}=    Convert Date    ${TO_DATE}    result_format=%Y-%m-%d %H:%M
    Should Be Equal    ${value_to_date}    ${to_date}

"Filter" button - "To Date" field in the "Filter" pop-up. - To verify function "Calendar" icon in "To Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Click "Calendar" icon in "To Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]

    #Select date and time.
    #Select time
    Click Element    xpath=/html/body/div[7]/div[2]/div[1]/button[2]
    ${selected_time}    Get Text    xpath=/html/body/div[7]/div[2]
    ${selected_time}=    Replace String    ${selected_time}    \n    ${EMPTY}

    #Select date
    ${selected_month_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div[1]/div
    ${txt_date}    Get Text    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[4]/td[7]/span
    ${selected_date}    Set Variable    ${txt_date}${selected_month_year}
    Click Element    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[4]/td[7]/span
    Wait Until Element Is Not Visible    xpath=//table[@class="p-datepicker-calendar"]

    #Check selected date and time result
    ${selected_to_date}    Convert Date    ${selected_date} ${selected_time}    date_format=%d%B%Y %H:%M    result_format=%Y-%m-%d %H:%M
    ${value_to_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/input
    Should Be Equal    ${value_to_date}    ${selected_to_date}

"Filter" button - "To Date" field in the "Filter" pop-up. - To verify function select month from "Calendar" icon in "To Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "To Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    ${txt_selected_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div[1]/div/button[2]

    #Click on "month"
    Click Element    xpath=/html/body/div[7]/div[1]/div/div[1]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${txt_current_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div/button
    Should Be Equal    ${txt_selected_year}    ${txt_current_year}

    #Click "Back" button
    Click Element    xpath=/html/body/div[7]/div[1]/div/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${num_current_year}=    Convert To Integer    ${txt_current_year}
    ${txt_previous_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div/button
    ${num_previous_year}=    Convert To Integer    ${txt_previous_year}
    Should Be Equal    ${num_previous_year}    ${num_current_year-1}

    ${txt_current_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div/button

    #Click "Next" button
    Click Element    xpath=/html/body/div[7]/div[1]/div/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${num_current_year}=    Convert To Integer    ${txt_current_year}
    ${txt_next_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div/button
    ${num_next_year}=    Convert To Integer    ${txt_next_year}
    Should Be Equal    ${num_next_year}    ${num_current_year+1}

    #Select month
    ${txt_current_month}   Get Text    xpath=/html/body/div[7]/div[2]/span[12]
    Click Element    xpath=/html/body/div[7]/div[2]/span[12]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]
    ${txt_current_month}    Convert Month Name    ${txt_current_month}
    ${txt_selected_month}   Get Text    xpath=/html/body/div[7]/div[1]/div/div[1]/div/button[1]
    Should Be Equal    ${txt_current_month}    ${txt_selected_month}

"Filter" button - "To Date" field in the "Filter" pop-up. - To verify function select year from "Calendar" icon in "To Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "To Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]
    
    ${txt_selected_year}    Get Text    xpath=/html/body/div[7]/div[1]/div/div[1]/div/button[2]
    ${num_selected_year}=    Convert To Integer    ${txt_selected_year}
    ${num_current_year}    Set Variable    ${num_selected_year}

    #Click on "year"
    Click Element    xpath=/html/body/div[7]/div[1]/div/div[1]/div/button[2]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${txt_current_decade}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div
    ${txt_current_decade_st}    ${txt_current_decade_ed}    Split String    ${txt_current_decade}    -
    ${num_current_decade_st}=    Convert To Integer    ${txt_current_decade_st}
    ${num_current_decade_ed}=    Convert To Integer    ${txt_current_decade_ed}
    Should Be Equal    ${num_current_decade_st}    ${${num_current_year} - (${num_current_year} % 10)}
    Should Be Equal    ${num_current_decade_ed}    ${${num_current_year} - (${num_current_year} % 10) + 9}

    #Click "Back" button
    Click Element    xpath=/html/body/div[7]/div[1]/div/div/button[1]
    ${num_current_year}    Set Variable    ${num_current_year-10}
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${txt_current_decade}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div
    ${txt_current_decade_st}    ${txt_current_decade_ed}    Split String    ${txt_current_decade}    -
    ${num_current_decade_st}=    Convert To Integer    ${txt_current_decade_st}
    ${num_current_decade_ed}=    Convert To Integer    ${txt_current_decade_ed}
    Should Be Equal    ${num_current_decade_st}    ${${num_current_year} - (${num_current_year} % 10)}
    Should Be Equal    ${num_current_decade_ed}    ${${num_current_year} - (${num_current_year} % 10) + 9}

    #Click "Next" button
    Click Element    xpath=/html/body/div[7]/div[1]/div/div/button[2]
    ${num_current_year}    Set Variable    ${num_current_year+10}
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${txt_current_decade}    Get Text    xpath=/html/body/div[7]/div[1]/div/div/div
    ${txt_current_decade_st}    ${txt_current_decade_ed}    Split String    ${txt_current_decade}    -
    ${num_current_decade_st}=    Convert To Integer    ${txt_current_decade_st}
    ${num_current_decade_ed}=    Convert To Integer    ${txt_current_decade_ed}
    Should Be Equal    ${num_current_decade_st}    ${${num_current_year} - (${num_current_year} % 10)}
    Should Be Equal    ${num_current_decade_ed}    ${${num_current_year} - (${num_current_year} % 10) + 9}

    #Select year
    ${txt_current_year}   Get Text    xpath=/html/body/div[7]/div[2]/span[10]
    Click Element    xpath=/html/body/div[7]/div[2]/span[10]
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[2]
    ${txt_selected_year}   Get Text    xpath=/html/body/div[7]/div[1]/div/div/div/button
    Should Be Equal    ${txt_current_year}    ${txt_selected_year}

"Filter" button - "To Date" field in the "Filter" pop-up. - To verify function select hour from "Calendar" icon in "To Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "To Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    ${txt_hour}    Get Text    xpath=/html/body/div[7]/div[2]/div[1]/span
    ${num_hour}=    Convert To Integer    ${txt_hour}

    #Click increse hour.
    Click Element    xpath=/html/body/div[7]/div[2]/div[1]/button[1]
    ${txt_new_hour}    Get Text    xpath=/html/body/div[7]/div[2]/div[1]/span
    ${num_new_hour}=    Convert To Integer    ${txt_new_hour}
    Should Be Equal    ${num_new_hour}    ${${num_hour+1}%60}

    ${num_hour}    Set Variable    ${${num_hour+1}%60}

    #Click decrese hour.
    Click Element    xpath=/html/body/div[7]/div[2]/div[1]/button[2]
    ${txt_new_hour}    Get Text    xpath=/html/body/div[7]/div[2]/div[1]/span
    ${num_new_hour}=    Convert To Integer    ${txt_new_hour}
    Should Be Equal    ${num_new_hour}    ${${num_hour-1}%60}

"Filter" button - "To Date" field in the "Filter" pop-up. - To verify function select minute from "Calendar" icon in "To Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "To Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    ${txt_minute}    Get Text    xpath=/html/body/div[7]/div[2]/div[3]/span
    ${num_minute}=    Convert To Integer    ${txt_minute}

    #Click increse minute.
    Click Element    xpath=/html/body/div[7]/div[2]/div[3]/button[1]
    ${txt_new_minute}    Get Text    xpath=/html/body/div[7]/div[2]/div[3]/span
    ${num_new_minute}=    Convert To Integer    ${txt_new_minute}
    Should Be Equal    ${num_new_minute}    ${${num_minute+1}%60}

    ${num_minute}    Set Variable    ${${num_minute+1}%60}

    #Click decrese minute.
    Click Element    xpath=/html/body/div[7]/div[2]/div[3]/button[2]
    ${txt_new_minute}    Get Text    xpath=/html/body/div[7]/div[2]/div[3]/span
    ${num_new_minute}=    Convert To Integer    ${txt_new_minute}
    Should Be Equal    ${num_new_minute}    ${${num_minute-1}%60}

"Filter" button - "To Date" field in the "Filter" pop-up. - To verify function "Today" button in "To Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "To Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    #Click "Today" button.
    Click Element    xpath=/html/body/div[7]/div[3]/button[1]
    ${value_to_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/input
    ${to_date}=    Get Current Date    UTC    + 7 hours    result_format=%Y-%m-%d %H:%M
    Set Global Variable    ${TO_DATE}    ${to_date}
    Should Be Equal    ${value_to_date}    ${TO_DATE}

"Filter" button - "To Date" field in the "Filter" pop-up. - To verify function "Clear" button in "To Date" field can work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "Calendar" icon in "To Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    # Select date and time.
    #Select time
    Click Element    xpath=/html/body/div[7]/div[2]/div[1]/button[2]

    #Select date
    Click Element    xpath=//table[@class="p-datepicker-calendar"]/tbody/tr[3]/td[7]/span
    Wait Until Element Is Not Visible    xpath=//table[@class="p-datepicker-calendar"]

    #Click "Calendar" icon in "To Date" field
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/button
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div[1]/div/div[2]

    #Click "Clear" button.
    Click Element    xpath=/html/body/div[7]/div[3]/button[2]

    #Check selected date and time result
    ${value_to_date}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[1]/div[4]/span/input
    Should Be Equal    ${value_to_date}    ${EMPTY}

"Filter" button - "Type" dropdown in the "Filter" pop-up. - To verify display and function of the "Type" dropdown can display correctly and work properly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Display auto keyword from current time and date
    ${value_type}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div
    Should Be Equal    ${value_type}    ${LOGTYPE}


    #Check Log type all options
    Click Element    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div
    Wait Until Element Is Visible    xpath=/html/body/div[7]/div/ul
    FOR    ${index}    IN RANGE    1    6
        ${txt_type_options}    Get Text    xpath=/html/body/div[7]/div/ul/li[${index}]
        Should Be Equal    ${txt_type_options}    ${LOGTYPE_OPTIONS}[${index-1}]
    END

    #Select new type in "Type." field.
    Click Element    xpath=/html/body/div[7]/div/ul/li[1]
    Wait Until Element Is Not Visible    xpath=/html/body/div[7]/div/ul
    ${value_type}    Get Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[2]/div
    Should Be Equal    ${value_type}    ${LOGTYPE_OPTIONS}[0]

"Filter" button - "Keyword" field in the "Filter" pop-up. - To verify display of the "Keyword" field can display correctly.
    [Tags]    Logs page

    #Click "Filter" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[1]
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div

    #Input keyword in "Keyword" field.
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input
    Input Text    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input    Search

    ${value_keyword}    Get Value    xpath=//*[@id="tmhth-criteria-filter"]/div/div[2]/div[4]/input
    Should Be Equal    ${value_keyword}    Search

"Export (CSV)" button - Display and function "Export (CSV)" button - To verify function of "Export (CSV)" button can work properly.
    [Tags]    Logs page

    #Click "Export (CSV)" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]
    Click Element    xpath=//*[@id="tmhth-criteria"]/div[2]/div/button[2]

    #Check the file is downloaded successfully.
    Log To Console    Waiting for the file to be downloaded...
    Wait Until Keyword Succeeds    30s    0.5s    File Should Exist    ${Download Directory}/logs*.csv
    Log To Console    File downloaded successfully.


"Display" dropdown. - "Display" dropdown. - To verify display and function of "Display" dropdown can display correctly and work properly.    #WIP
    [Tags]    Logs page

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

Logs data list table. - "Action" icon. - To verify function of "Action" icon can work properly.
    [Tags]    Logs 
    
    #Click "Action" icon
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[4]/label/i

    #Check "Logs details" pop-up display
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    ${txt_logs_detail}    Get Text    xpath=/html/body/div[6]/div/div[1]/span
    Should Be Equal    ${txt_logs_detail}    Logs Detail

    #"X" button.
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[1]/div/button

    #Message "Datetime" with details.
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[1]/div[1]/div/label
    ${txt_datetime}    Get Text    xpath=/html/body/div[6]/div/div[2]/div/div[1]/div[1]/div/label
    Should Be Equal    ${txt_datetime}    Datetime

    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[1]/div[2]/label

    #Message "From Address"  with details.
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[2]/div[1]/div/label
    ${txt_from_address}    Get Text    xpath=/html/body/div[6]/div/div[2]/div/div[2]/div[1]/div/label
    Should Be Equal    ${txt_from_address}    From Address

    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[2]/div[2]/label

    #Message "Type" with details.
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[3]/div[1]/div/label
    ${txt_type}    Get Text    xpath=/html/body/div[6]/div/div[2]/div/div[3]/div[1]/div/label
    Should Be Equal    ${txt_type}    Type

    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[3]/div[2]/label

    #Message "Message" with details.
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[4]/div[1]/div/label
    ${txt_message}    Get Text    xpath=/html/body/div[6]/div/div[2]/div/div[4]/div[1]/div/label
    Should Be Equal    ${txt_message}    Message

    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[4]/div[2]/label

    #Message "Detail" with details.
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[5]/div[1]/div/label
    ${txt_datail}    Get Text    xpath=/html/body/div[6]/div/div[2]/div/div[5]/div[1]/div/label
    Should Be Equal    ${txt_datail}    Detail

    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[5]/div[2]/p


Logs data list table. - "Action" icon. - To verify display and function of "Logs details" pop-up can display correctly and work properly.
    [Tags]    Logs 
    
    #Click "Action" icon
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[4]/label/i
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Click "X" button
    Click Element    xpath=/html/body/div[6]/div/div[1]/div/button
    Wait Until Element Is Not Visible    xpath=/html/body/div[6]/div
    Element Should Not Be Visible    xpath=/html/body/div[6]/div

Logs data list table. - "Action" icon. - To verify function of scroll down in "Logs details" pop-up in case details can work properly.
    [Tags]    Logs 
    
    #Click "Action" icon
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Click Element    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody/tr[1]/td[4]/label/i
    Wait Until Element Is Visible    xpath=/html/body/div[6]/div
    
    #Scroll down
    Scroll Element Into View    xpath=/html/body/div[6]/div/div[2]/div/div[5]/div[2]/p
    Element Should Be Visible    xpath=/html/body/div[6]/div/div[2]/div/div[5]/div[2]/p


Logs data list table. - "First Page" button. - To verify function of "First Page" button can work properly.
    [Tags]    Logs

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


Logs data list table. - "First Page" button. - To verify function of "First Page" button in case already in first page of key carts data list table can work properly.
    [Tags]    Logs

    #Check "First Page" button is disabled
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[1]

    ${txt_page_number}    Get Text    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[3]
    Should Be Equal    ${txt_page_number}    1

    ${button_first_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[1]    class
    Should Contain    ${button_first_page}    p-disabled


Logs data list table. - "Back Page" button. - To verify function of "Back Page" button can work properly.
    [Tags]    Logs

    #Go to Last page
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

Logs data list table. - "Back Page" button. - To verify function of "Back Page" button in case already in first page of key carts data list table can work properly.
    [Tags]    Logs
    
    #At First page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    #Check "Back Page" button is disabled
    ${button_back_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[2]    class
    Should Contain    ${button_back_page}    p-disabled

Logs data list table. - "Page Number" button. - To verify display and function of "Page Number" button can display correctly and work properly.
    [Tags]    Logs
    
    #Click "Page Number" button at page 3
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[5]

    ${txt_page_number}    Get Text    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[5]
    Should Be Equal    ${txt_page_number}    3
    
    Click Element    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[5]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    ${pagination_current_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[5]    class
    Should Contain    ${pagination_current_page}    p-active

Logs data list table. - "Next Page" button. - To verify function of "Next Page" button can work properly.
    [Tags]    Logs
    
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


Logs data list table. - "Next Page" button. - To verify function of "Next Page" button in case already in last page of key carts data list table can work properly.
    [Tags]    Logs

    #Go to Last page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Click Button   xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    #Check "Next Page" button is disabled
    ${button_next_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()-1]    class
    Should Contain    ${button_next_page}    p-disabled


Logs data list table. - "Last Page" button. - To verify function of "Last Page" button can work properly.
    [Tags]    Logs

    #Click "Last Page" button
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Click Button   xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    ${pagination_current_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()-2]    class
    Should Contain    ${pagination_current_page}    p-active


Logs data list table. - "Last Page" button. - To verify function of "Last Page" button in case already in last page of key carts data list table can work properly.
    [Tags]    Logs

    #Go to Last page
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody
    Scroll Element Into View    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Click Button   xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]
    Wait Until Element Is Visible    xpath=//*[@id="tmhth-criteria-result"]/div[2]/div/div/div/div[1]/table/tbody

    #Check "Last Page" button is disabled
    ${button_last_page}    Get Element Attribute    xpath=//*[@id="tmhth-criteria-pagination"]/nav/button[last()]    class
    Should Contain    ${button_last_page}    p-disabled



