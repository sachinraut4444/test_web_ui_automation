*** Settings ***
Documentation    Added scenarios related to Cart Page

Resource    ../resources/lib_resource.robot
Resource    ../page_object/lib_page_object.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${parameters_Login}
Test Teardown    Exit browser

*** Test Cases ***
Verify user should remove product form cart
    [Tags]    cart-1    cart_scenario     regression
    ${product_input_data}     read json file and return test data     two_product_list_file.json
    Add product to cart based on input file and verify shopping count with cart on inventory page       ${product_input_data}
    ${selected_product_name_list}    Get Dictionary Keys     ${product_input_data}
    Proceed to view item on cart page
    Verify selected product count with shopping cart count
    Unselect product on cart page        ${selected_product_name_list}[0]    True
    Verify selected product count with shopping cart count

Verify user should remove all product form cart
    [Tags]    cart-2    cart_scenario     regression
    ${product_input_data}     read json file and return test data     all_product_list_file.json
    Add product to cart based on input file and verify shopping count with cart on inventory page       ${product_input_data}
    ${selected_product_name_list}    Get Dictionary Keys     ${product_input_data}
    Proceed to view item on cart page
    Verify selected product count with shopping cart count
    FOR     ${key}  IN  @{product_input_data.keys()}
        Unselect product on cart page     ${key}    True
    END
    Verify selected product count with shopping cart count

Verify user should remove product form cart and add new product from product page
    [Tags]    cart-3    cart_scenario     regression
    ${product_input_data}     read json file and return test data     two_product_list_file.json
    Add product to cart based on input file and verify shopping count with cart on inventory page       ${product_input_data}
    ${selected_product_name_list}    Get Dictionary Keys     ${product_input_data}
    Proceed to view item on cart page
    Verify selected product count with shopping cart count
    Unselect product on cart page        ${selected_product_name_list}[0]    True
    Verify selected product count with shopping cart count
    Navigate to product page from cart section
    ${product_input_data}     read json file and return test data     all_product_list_file.json
    Add product to cart based on input file and verify shopping count with cart on inventory page       ${product_input_data}
    Proceed to view item on cart page
    Verify selected product count with shopping cart count

Verify user should able to open single product and remove product from cart
    [Tags]    cart-4    cart_scenario     regression
    ${product_input_data}     read json file and return test data     two_product_list_file.json
    Add product to cart based on input file and verify shopping count with cart on inventory page       ${product_input_data}
    ${selected_product_name_list}    Get Dictionary Keys     ${product_input_data}
    Proceed to view item on cart page
    Verify selected product count with shopping cart count
    open product from cart page     ${selected_product_name_list}[0]
    Click element on inventory page     remove_single_product_from_detail_view
    Proceed to view item on cart page
    Verify selected product count with shopping cart count






