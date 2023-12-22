*** Settings ***
Documentation    Added End to End Scenarios

Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${parameters_Login}
Test Teardown    Exit browser
*** Test Cases ***
Standard user should place order for all products without any error
    [Tags]    e2e-1    end_to_end     regression

    Place order       two_product_list_file.json

Verify standard user should be able to perform actions such as adding, removing, and updating products, as well as placing orders for selected items without encountering any errors
    [Tags]    e2e-2    end_to_end     regression

    ${product_data}     read json file and return test data     single_product_list_file.json
    FOR     ${key}  IN  @{product_data.keys()}
        select_unselect_product_on_inventory_page     ${key}
    END
    Verify selected product count with shopping cart count
    Proceed to view item on cart page
    ${selected_product_name_list}       Get dictionary keys     ${product_data}
    Unselect product on cart page        ${selected_product_name_list}[0]    True
    Navigate to product page from cart section
    Place order    two_product_list_file.json

Verify that standard user can place multiple orders without any error
    [Tags]    e2e-3    end_to_end     regression
    [Template]      place order
        single_product_list_file.json
        all_product_list_file.json

