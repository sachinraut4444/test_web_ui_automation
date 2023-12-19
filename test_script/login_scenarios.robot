*** Settings ***
Documentation    Suite description

Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

*** Test Cases ***
Login to sauce demo application
    [Tags]    12345

    Login to application    ${parameters_Login}

    [Teardown]    Exit browser