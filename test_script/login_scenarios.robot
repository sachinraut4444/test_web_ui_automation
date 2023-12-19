*** Settings ***
Documentation    Suite description

Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Navigate to url     ${parameters_Login}[0]    ${parameters_Login}[1]      ${parameters_Login}[2]
*** Test Cases ***
Login to sauce demo application with valid user
    [Setup]    Login to application    ${parameters_Login}
    [Tags]    login     1

    ${page_title}   InventoryClass.Get element text    product_title
    Verify string should match      Products        ${page_title}

    [Teardown]    Exit browser

#Verify user should get validation error for empty
#    [Tags]      login       2
#
#
#    [Teardown]    Exit browser