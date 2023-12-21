*** Settings ***
Documentation    Scenarios related user information

Resource    ../resources/lib_resource.robot
Resource    ../page_object/lib_page_object.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${parameters_Login}
Test Teardown    Exit browser

*** Test Cases ***
verify user gets validation message if fails to fill all fields
    [Documentation]     This scenario cover four negative test case to validate error message
    [Tags]    1234

    Verify user successfully added few products into cart    two_product_list_file.json
    Verify user information for invalid information    ${EMPTY}         ${user_last_name}   ${postal_code}       Error: First Name is required
    Verify user information for invalid information    ${user_first_name}   ${EMPTY}   ${postal_code}       Error: Last Name is required
    Verify user information for invalid information    ${user_first_name}   {user_last_name}   ${EMPTY}       Error: Postal Code is required
    Verify user information for invalid information    ${EMPTY}   ${EMPTY}   ${EMPTY}       Error: First Name is required






