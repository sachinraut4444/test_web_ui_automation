*** Keywords ***
Verify string should match
    [Arguments]    ${expected_string}   ${actual_string}
    Run keyword and continue on failure    Should be equal as strings       ${expected_string}   ${actual_string}
