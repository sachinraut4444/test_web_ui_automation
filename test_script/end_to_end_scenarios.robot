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
        Select product on inventory page     ${key}
    END
    Verify selected product count on inventory page
    InventoryClass.Click element on page locator    shopping_cart
    Verify selected product on cart page      ${product_data}
    Proceed with checkout from cart page
    Add user information        ${user_first_name}   ${user_last_name}   ${postal_code}
    Proceed with continue to confirm order details
    Verify selected product on checkout page        ${product_data}
    Proceed with finish order
    Verify order confirmation message
    Navigate to product list page after confirming order





