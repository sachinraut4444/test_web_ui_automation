*** Settings ***
Library           Collections
Library           OperatingSystem
Library           String

*** Keywords ***

call function from keyword
    log to console      connected successfully

read json file and return test data
    [Arguments]     ${json_file_name}
    ${file_name}        catenate    test_data/${json_file_name}
    ${json_file}        Get File    ${file_name}
    ${test_data_dict}    Evaluate  json.loads('''${json_file}''')     json
    [Return]    ${test_data_dict}