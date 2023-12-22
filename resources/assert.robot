*** Settings ***
Documentation     This file has assertion related scenarios

Resource    ../page_object/lib_page_object.robot
Resource    ../resources/lib_resource.robot

*** Keywords ***
Verify string should match
    [Arguments]    ${expected_string}   ${actual_string}
    Run keyword and continue on failure    Should be equal as strings       ${expected_string}   ${actual_string}

verify number
	[Arguments]    ${expectedValue}     ${actualValue}
	${actualValue}      convert to integer   ${actualValue}
	${expectedValue}    convert to integer   ${expectedValue}
	RUN KEYWORD AND CONTINUE ON FAILURE	    Should Be Equal     ${expectedValue}    ${actualValue}