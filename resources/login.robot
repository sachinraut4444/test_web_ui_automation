*** Settings ***
Documentation     This file has login scenarios

Resource    ../page_object/lib_page_object.robot
Resource    ../resources/lib_resource.robot

Library         SeleniumLibrary

*** Keywords ***
Login to application
	[Arguments]	    ${parameters}
	Navigate to url     ${parameters}[0]    ${parameters}[1]    ${parameters}[2]
	LoginClass.Wait until element visible on page           user_name
	LoginClass.Enter Text In Input Box     user_name       ${parameters}[3]
	LoginClass.Enter text in input box     password       ${parameters}[4]
	${login_button}     LoginClass.Return element page locator    login_button
	Click element       ${login_button}
    InventoryClass.Wait until element visible on page    inventory_container

verify login functionality for invalid credentials
    [Arguments]    ${user_name}     ${password}     ${expected_error_text}
    Input username and password in login form       ${user_name}     ${password}
    ${actual_error_text}       LoginClass.Get element text     login_error_button
    assert.Verify string should match    ${expected_error_text}     ${actual_error_text}
    Reload page

input username and password in login form
    [Arguments]    ${user_name}     ${password}

    LoginClass.Wait until element visible on page       user_name
    LoginClass.Clear input box text    user_name
    LoginClass.Clear input box text    password
    LoginClass.Enter Text In Input Box     user_name       ${user_name}
	LoginClass.Enter text in input box     password       ${password}
	LoginClass.Click element on page locator       login_button

logout from the application
    Click element on inventory page    side_menu_open_button
    Click element on inventory page     side_menu_logout_button

Re-login to application
    [Arguments]    ${parameters}
    LoginClass.Enter Text In Input Box     user_name       ${parameters}[3]
	LoginClass.Enter text in input box     password       ${parameters}[4]
	LoginClass.Click element on page locator       login_button
    InventoryClass.Wait until element visible on page    inventory_container
