*** Settings ***
Documentation    Scenarios related order overview

Resource    ../resources/lib_resource.robot
Resource    ../page_object/lib_page_object.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${parameters_Login}
Test Teardown    Exit browser

*** Test Cases ***
#verify count of selected product on checkout overview page
#    [Documentation]
#    [Tags]    1234
#    ${product_data}     Verify user successfully added few products into cart    two_product_list_file.json
#    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
#    Verify selected product on checkout page        ${product_data}
#
#verify total price of selected product on checkout overview page
#    [Documentation]
#    [Tags]    1234
#    ${product_data}     Verify user successfully added few products into cart    two_product_list_file.json
#    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
#    Verify total price of selected product    ${product_data}

#verify payment and shipping information for selected product on checkout overview page
#    [Documentation]
#    [Tags]    1234
#    ${product_data}     Verify user successfully added few products into cart    two_product_list_file.json
#    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
#    verify payment information     SauceCard #31337
#    Verify shipping information    Free Pony Express Delivery!
#
#Verify that on Cancel action user should navigate to inventory page
#    [Tags]    1234
#    ${product_data}     Verify user successfully added few products into cart    two_product_list_file.json
#    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
#    Proceed with cancel from confirm order page
#    Check element visible inventory on page       sort_icon
#
Verify user should able to open single product from confirmation page
    [Tags]    12345
    ${product_data}     Verify user successfully added few products into cart    two_product_list_file.json
    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
    ${selected_product_name_list}    Get Dictionary Keys     ${product_data}
    open product from cart page     ${selected_product_name_list}[0]
    Click element on inventory page     remove_single_product_from_detail_view
    Proceed to view item on cart page
    Verify selected product count with shopping cart count

Verify that on checkout confirmation page, user should navigate cart page and able to remove product
    [Tags]    12345
    ${product_data}     Verify user successfully added few products into cart    two_product_list_file.json
    Add user information proceed with continue to confirm order details        ${user_first_name}   ${user_last_name}   ${postal_code}
    Proceed to view item on cart page
    ${selected_product_name_list}    Get Dictionary Keys     ${product_data}
    open product from cart page     ${selected_product_name_list}[0]
    Unselect product on cart page        ${selected_product_name_list}[0]    True

