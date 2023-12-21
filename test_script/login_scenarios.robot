*** Settings ***
Documentation    Suite description

Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Navigate to url     ${parameters_Login}[0]    ${parameters_Login}[1]      ${parameters_Login}[2]
Test Teardown    Exit browser
*** Test Cases ***
Verify that valid user able to login into application without any error
    [Setup]    Login to application    ${parameters_Login}
    [Tags]    login     1

    ${page_title}   InventoryClass.Get element text    product_title
    Verify string should match      Products        ${page_title}

    [Teardown]    Exit browser

Verify Validation Error Message for Invalid Login
    [Tags]      login       2
    [Template]    verify login functionality for invalid credentials
        invalid user    invalid password        Epic sadface: Username and password do not match any user in this service
        standard_user   invalid password       Epic sadface: Username and password do not match any user in this service
        invalid user    secret_sauce            Epic sadface: Username and password do not match any user in this service
        ${EMPTY}        secret_sauce            Epic sadface: Username is required
        ${EMPTY}        ${EMPTY}                Epic sadface: Username is required
        standard_user       ${EMPTY}           Epic sadface: Password is required

Verify login activity locked for user after unsuccessful login retry
    [Tags]      login       3

    Input username and password in login form       ${locked_user_parameters_Login}[3]  ${locked_user_parameters_Login}[4]
    ${actual_error_text}       LoginClass.Get element text     login_error_button
    assert.Verify string should match     Epic sadface: Sorry, this user has been locked out.        ${actual_error_text}

Verify that user should navigate to login page after logout
    [Setup]    Login to application    ${parameters_Login}
    [Tags]      login       311

    logout from the application
    LoginClass.Wait until element visible on page       user_name



