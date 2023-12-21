*** Settings ***
Documentation    Scenarios related to problem_user


Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${visual_user_parameters_Login}
Test Teardown    Exit browser
*** Test Cases ***
Verify that product are not misaligned on page
    [Tags]    12345
    Verify ad to cart element aligned properly

Verify user should get error message due to web element mis-alignment
    [Tags]    12345
        ${product_data}     read json file and return test data     two_product_list_file.json
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Verify selected product count with shopping cart count
    Proceed to view item on cart page

