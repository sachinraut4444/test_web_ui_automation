*** Settings ***
Documentation    Scenarios related to Inventory Page

Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${parameters_Login}
Test Teardown    Exit browser

*** Variables ***
@{sorting_expected_all_options}      Name (A to Z)     Name (Z to A)     Price (low to high)   Price (high to low)
@{sorting_expected_selected_option}      Name (A to Z)

*** Test Cases ***
Verify user should open and close side navigation bar
    [Tags]    12345
    Click element on inventory page    side_menu_open_button
    Click element on inventory page    side_menu_close_button

Verify all buttons on navigation bar
    [Tags]    12345
    Click element on inventory page     side_menu_open_button
    Check element visible on page       side_menu_all_item_button
    Check element visible on page       side_menu_about_button
    Check element visible on page       side_menu_logout_button
    Check element visible on page       side_menu_reset_button
    Click element on inventory page     side_menu_close_button

Verify sorting dropdown intractable on inventory page
    [Tags]    12345

    Check element visible on page       sort_icon
    ${sorting_drop_down}    Get inventory element locator       sort_icon
    ${available_sorting_options}    Get List Items      ${sorting_drop_down}
    ${sorting_actual_selected_option}    Get Selected List Labels    ${sorting_drop_down}
    Lists should be equal       ${sorting_expected_selected_option}      ${sorting_actual_selected_option}
    Lists should be equal       ${sorting_expected_all_options}      ${available_sorting_options}

Verify that products are sorted by default alphabetically by name
    [Tags]    133

    ${product_name_price_dictionary}    Get all product name and price from inventory page
    ${keys_list}=    Evaluate    [key for key in ${product_name_price_dictionary}]
    ${is_sorted}=    Evaluate    sorted(${keys_list}) == ${keys_list}
    Should Be True    ${is_sorted}    List is not sorted alphabetically

Verify price sorting with ascending order
    [tags]    1234


    ${product_name_price_dictionary}    Get all product name and price from inventory page
    ${values_list}=    Evaluate    [value for key, value in ${product_name_price_dictionary}.items()]
    Log to console      ${values_list}
    ${is_sorted}=    Evaluate    sorted(${values_list}) == ${values_list}
    #Should Be True    ${is_sorted}    List is not sorted alphabetically






