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

Verify price sorting functionality with ascending order
    [tags]    1234

    ${product_name_price_default_dictionary}    Get all product name and price from inventory page
    ${product_name_price_expected_price_sort_list}    Evaluate    sorted(${product_name_price_default_dictionary}.items(), key=lambda x: float(x[1].replace('$', '')))
    Sort inventory product      Price (low to high)
    verify sorted product on inventory page         ${product_name_price_expected_price_sort_list}

Verify shopping cart count should be updated as per user activity
    [Tags]    1234
    select_unselect_product_on_inventory_page        Sauce Labs Backpack
    Verify selected product count with shopping cart count
    select_unselect_product_on_inventory_page        Test.allTheThings() T-Shirt (Red)
    Verify selected product count with shopping cart count
    select_unselect_product_on_inventory_page        Test.allTheThings() T-Shirt (Red)       True
    Verify selected product count with shopping cart count

Verify user should able to add all products into cart
    [Tags]    1234
    ${product_data}     read json file and return test data     all_product_list_file.json
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Verify selected product count with shopping cart count

Verify user should able to remove all selected products from cart
    [Tags]    1234
    ${product_data}     read json file and return test data     all_product_list_file.json
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Verify selected product count with shopping cart count
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}    True
    END
    Verify selected product count with shopping cart count

Verify that selected product should not disappear from cart after re-login
    [Tags]    123

    select_unselect_product_on_inventory_page        Sauce Labs Backpack
    Verify selected product count with shopping cart count
    select_unselect_product_on_inventory_page        Test.allTheThings() T-Shirt (Red)
    Verify selected product count with shopping cart count
    Logout from the application
    Re-login to application        ${parameters_Login}
    ${actual_selected_product}      InventoryClass.Get element text     shopping_cart
    Verify number       2       ${actual_selected_product}










