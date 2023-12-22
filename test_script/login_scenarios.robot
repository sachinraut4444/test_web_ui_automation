*** Settings ***
Documentation    Added login related scenarios

Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Navigate to url     ${parameters_Login}[0]    ${parameters_Login}[1]      ${parameters_Login}[2]
Test Teardown    Exit browser
*** Test Cases ***
Verify that valid user able to login into application without any error
    [Setup]    Login to application    ${parameters_Login}
    [Tags]    lp-1    login_page     regression
    ${page_title}   InventoryClass.Get element text    product_title
    Verify string should match      Products        ${page_title}

    [Teardown]    Exit browser

Verify that valid user able to login into application without any error for firefox browser
    [Setup]
    [Tags]    lp-2   login_page     regression
    Navigate to url     ${parameters_Login}[0]    Firefox      ${parameters_Login}[2]
    Input username and password in login form       ${parameters_Login}[3]  ${parameters_Login}[4]
    ${page_title}   InventoryClass.Get element text    product_title
    Verify string should match      Products        ${page_title}

    [Teardown]    Exit browser

Verify Validation Error Message for Invalid Login
    [Documentation]    This scenario covers different negative scenarios related to passing invalid credentials
    [Tags]      lp-3    login_page     regression
    [Template]    verify login functionality for invalid credentials
        invalid user    invalid password        Epic sadface: Username and password do not match any user in this service
        standard_user   invalid password       Epic sadface: Username and password do not match any user in this service
        invalid user    secret_sauce            Epic sadface: Username and password do not match any user in this service
        ${EMPTY}        secret_sauce            Epic sadface: Username is required
        ${EMPTY}        ${EMPTY}                Epic sadface: Username is required
        standard_user       ${EMPTY}           Epic sadface: Password is required

Verify login activity locked for user after unsuccessful login retry
    [Tags]      lp-4    login_page     regression

    Input username and password in login form       ${locked_user_parameters_Login}[3]  ${locked_user_parameters_Login}[4]
    ${actual_error_text}       LoginClass.Get element text     login_error_button
    assert.Verify string should match     Epic sadface: Sorry, this user has been locked out.        ${actual_error_text}

Verify that user should navigate to login page after logout
    [Setup]    Login to application    ${parameters_Login}
    [Tags]      lp-5    login_page     regression

    logout from the application
    LoginClass.Wait until element visible on page       user_name

Verify that user can logout from any section
    [Setup]    Login to application    ${parameters_Login}
    [Tags]      lp-6    login_page     regression

    ${product_data}     Verify user successfully added few products into cart    two_product_list_file.json
    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
    Verify total price of selected product    ${product_data}
    logout from the application
    LoginClass.Wait until element visible on page       user_name


