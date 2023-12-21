*** Settings ***
Documentation    Scenarios related to problem_user


Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Teardown    Exit browser
*** Test Cases ***
#Verify product detail page load within one second for performance glitch user
#    [setup]    Navigate to url     ${parameters_Login}[0]    ${parameters_Login}[1]      ${parameters_Login}[2]
#    [Tags]    12345678
#    Load product page within one second after login       ${performance_glitch_user_parameters_Login}
#
#Verify product detail page load within one second for standard user
#    [setup]    Navigate to url     ${parameters_Login}[0]    ${parameters_Login}[1]      ${parameters_Login}[2]
#    [Tags]    12345678
#    Load product page within one second after login           ${parameters_Login}

Verify product should sort within one second for performance glitch user
    [setup]         Login to application    ${performance_glitch_user_parameters_Login}
    [Tags]    12345678
    Load product on page within one second after sort on product page

Verify product should sort within one second for standard user
    [setup]    Login to application     ${parameters_Login}
    [Tags]    12345678
    Load product on page within one second after sort on product page

