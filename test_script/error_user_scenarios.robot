*** Settings ***
Documentation    Added error user related scenarios


Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${error_user_parameters_Login}
Test Teardown    Exit browser
*** Test Cases ***
Verify user should able to remove selected products from inventory page
    [Tags]    eu-1    error_user     regression
    ${product_data}     read json file and return test data     single_product_list_file.json
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Verify selected product count with shopping cart count
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}    False
    END
    Verify selected product count with shopping cart count

Verify that user should able to fill user information correctly
    [Tags]    eu-2    error_user     regression

    ${product_data}     read json file and return test data     single_product_list_file.json
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Proceed to view item on cart page
    Proceed with checkout from cart page
    Add user information proceed with continue to confirm order details    ${user_first_name}   ${user_last_name}   ${postal_code}

Verify that user should not place order for invalid order process
    [Documentation]    The user information input box validation is tested in another scenario
    [Tags]    eu-3    error_user     regression

    ${product_data}     read json file and return test data     single_product_list_file.json
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Proceed to view item on cart page
    Proceed with checkout from cart page
    Add user information proceed with continue to confirm order details    ${user_first_name}   ${EMPTY}   ${postal_code}
    Proceed with finish order
    Verify order confirmation message

