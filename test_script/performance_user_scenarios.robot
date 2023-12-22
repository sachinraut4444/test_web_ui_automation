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

[Expected to FAIL]Verify user should navigate immediately to product list page after completing order for performance glitch user
    [Setup]         Login to application    ${performance_glitch_user_parameters_Login}
    [Tags]    pu-5    performance_user     regression       negative_scenario
    ${product_data}     Verify user successfully added few products into cart    two_product_list_file.json
    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
    Verify selected product on checkout page        ${product_data}
    Proceed with finish order
    Verify order confirmation message
    Load product detail page within one second after confirming order

Verify user should navigate immediately to product list page after completing order for standard user
    [Setup]         Login to application    ${parameters_Login}
    [Tags]    pu-6   performance_user     regression       negative_scenario
    ${product_data}     Verify user successfully added few products into cart    two_product_list_file.json
    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
    Verify selected product on checkout page        ${product_data}
    Proceed with finish order
    Verify order confirmation message
    Load product detail page within one second after confirming order
