*** Settings ***
Documentation    This file has commonly used keyword implementation

Library           Collections
Library           OperatingSystem
Library           String

Resource    ../page_object/lib_page_object.robot
Resource    ../resources/lib_resource.robot

*** Keywords ***

call function from keyword
    log to console      connected successfully

read json file and return test data
    [Arguments]     ${json_file_name}
    ${file_name}        catenate    test_data/${json_file_name}
    ${json_file}        Get File    ${file_name}
    ${test_data_dict}    Evaluate  json.loads('''${json_file}''')     json
    [Return]    ${test_data_dict}

place order
    [Arguments]     ${product_list_file}
        ${product_data}     read json file and return test data     ${product_list_file}
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Verify selected product count with shopping cart count
    Proceed to view item on cart page
    Verify selected product on cart page      ${product_data}
    Proceed with checkout from cart page
    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
    Verify selected product on checkout page        ${product_data}
    Proceed with finish order
    Verify order confirmation message
    Navigate to product list page after confirming order

sort inventory product
    [Arguments]    ${sorting_type}
    ${sorting_element_path}     Get inventory element locator    sort_icon
    Select From List By Label       ${sorting_element_path}         ${sorting_type}

verify sorted product on inventory page
    [Arguments]    ${product_name_price_expected_price_sort_list}

    ${product_name_price_sort_actual_dictionary}    Get all product name and price from inventory page
    ${product_name_price_sort_actual_list}    Evaluate    [(key, value) for key, value in ${product_name_price_sort_actual_dictionary}.items()]
    Lists Should Be Equal        ${product_name_price_expected_price_sort_list}    ${product_name_price_sort_actual_list}

add product to cart based on input file and verify shopping count with cart on inventory page
    [Arguments]    ${input_data_file}

    FOR     ${key}  IN  @{input_data_file.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Verify selected product count with shopping cart count

open product from cart page
    [Arguments]    ${product_name}
    ${product_path}     BaseClass.Get product name path    ${product_name}
    Click element    ${product_path}

verify user successfully added few products into cart
    [Arguments]    ${product_input_file}
    ${product_data}     read json file and return test data     ${product_input_file}
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Verify selected product count with shopping cart count
    proceed_to_view_item_on_cart_page
    Verify selected product on cart page      ${product_data}
    Proceed with checkout from cart page
    [Return]    ${product_data}

verify user information for invalid information
    [Arguments]    ${user_first_name}   ${user_last_name}   ${postal_code}     ${expected_error_text}
    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
    ${actual_error_text}       CheckoutUserInformationClass.Get element text    error_button
    assert.Verify string should match    ${expected_error_text}     ${actual_error_text}
    Reload page

verify payment information
    [Arguments]    ${expected_payment_information}

    ${actual_payment_information}       CheckoutOverviewClass.Get element text      payment_information_element
    Verify string should match    ${expected_payment_information}       ${actual_payment_information}


verify shipping information
    [Arguments]    ${expected_shipping_information}
    ${actual_shipping_information}       CheckoutOverviewClass.Get element text      shipping_information_element
    Verify string should match    ${expected_shipping_information}      ${actual_shipping_information}

