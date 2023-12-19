*** Settings ***
Documentation     This file has login scenarios

Resource    ../page_object/lib_page_object.robot
Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

*** Keywords ***
Login to application
	[Arguments]	    ${parameters}
	Navigate to url     ${parameters}[0]    ${parameters}[1]    ${parameters}[2]
	LoginClass.Enter Text In Input Box     user_name       ${parameters}[3]
	LoginClass.Enter text in input box     password       ${parameters}[4]
	LoginClass.Click element on page locator       login_button
    InventoryClass.Wait until element visible on page    inventory_container
