*** Settings ***
Documentation    Scenarios related to problem_user


Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${problem_user_parameters_Login}
Test Teardown    Exit browser
*** Test Cases ***
#Verify user should select all products from product inventory page
#    [Tags]    12345
#
#    ${product_data}     read json file and return test data     all_product_list_file.json
#    FOR     ${key}  IN  @{product_data.keys()}
#        select_unselect_product_on_inventory_page     ${key}
#    END
#    Verify selected product count with shopping cart count

Verify that product display with respective images
    [Tags]    12345

    Verify respective image display for product on inventory page





