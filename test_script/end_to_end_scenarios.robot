*** Settings ***
Documentation    End to End Scenarios

Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

Test Setup    Login to application    ${parameters_Login}
Test Teardown    Exit browser
*** Test Cases ***
Standard user should place order for all products without any error
    [Tags]    12345

    #${product_data}     read json file and return test data     all_product_list_file.json
    InventoryClass.Select product on inventory      Sauce Labs Onesie
    InventoryClass.Select product on inventory      Sauce Labs Bike Light
    InventoryClass.Verify selected product count


