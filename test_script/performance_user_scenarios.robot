*** Settings ***
Documentation    Added scenarios related to performance user


Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Teardown    Exit browser
*** Test Cases ***
[Expected to FAIL]Verify product detail page load within one second for performance glitch user
    [Setup]    Navigate to url     ${parameters_Login}[0]    ${parameters_Login}[1]      ${parameters_Login}[2]
    [Tags]    pu-1    performance_user     regression       negative_scenario
    Load product page within one second after login       ${performance_glitch_user_parameters_Login}

Verify product detail page load within one second for standard user
    [Setup]    Navigate to url     ${parameters_Login}[0]    ${parameters_Login}[1]      ${parameters_Login}[2]
    [Tags]    pu-2    performance_user     regression
    Load product page within one second after login           ${parameters_Login}

[Expected to FAIL]Verify product should sort within one second for performance glitch user
    [Setup]         Login to application    ${performance_glitch_user_parameters_Login}
    [Tags]    pu-3    performance_user     regression       negative_scenario
    Load product on page within one second after sort on product page

Verify product should sort within one second for standard user
    [Setup]    Login to application     ${parameters_Login}
    [Tags]    pu-4    performance_user     regression
    Load product on page within one second after sort on product page

