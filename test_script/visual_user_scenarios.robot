*** Settings ***
Documentation    Added scenarios related to visual users


Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${visual_user_parameters_Login}
Test Teardown    Exit browser
*** Test Cases ***
[Expected to FAIL]Verify that product are not misaligned on page
    [Tags]    vu-1    visual_user     regression    negative_scenario
    Verify ad to cart element aligned properly

[Expected to FAIL]Verify user should get error message due to web element mis-alignment
    [Tags]    vu-2    visual_user     regression        negative_scenario
        ${product_data}     read json file and return test data     two_product_list_file.json
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Verify selected product count with shopping cart count
    Proceed to view item on cart page

