*** Settings ***
Documentation    End to End Scenarios

Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${parameters_Login}
Test Teardown    Exit browser
*** Test Cases ***
Standard user should place order for all products without any error
    [Tags]    12345

    ${product_data}     read json file and return test data     two_product_list_file.json
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Verify selected product count with shopping cart count
    proceed_to_view_item_on_cart_page
    Verify selected product on cart page      ${product_data}
    Proceed with checkout from cart page
    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
    Verify selected product on checkout page        ${product_data}
    Proceed with finish order
    Verify order confirmation message
    Navigate to product list page after confirming order





