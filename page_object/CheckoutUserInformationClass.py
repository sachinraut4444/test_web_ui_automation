from BaseClass import BaseClass
import logging

from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time


class CheckoutUserInformationClass(BaseClass):
    _locators = {
        "first_name_input_box": "id=first-name",
        "last_name_input_box": "id=last-name",
        "postal_code_input_box": "id=postal-code",
        "continue_button": "id=continue",
        "error_button": "xpath=//h3[@data-test='error']"
    }

    def add_user_information_proceed_with_continue_to_confirm_order_details(self, first_name, last_name, postal_code):
        # Input user information
        self.selib.input_text(self.locator["first_name_input_box"], first_name)
        self.selib.input_text(self.locator["last_name_input_box"], last_name)
        self.selib.input_text(self.locator["postal_code_input_box"], postal_code)

        # Retrieve actual values
        actual_first_name = self.selib.get_value(self.locator["first_name_input_box"])
        actual_last_name = self.selib.get_value(self.locator["last_name_input_box"])
        actual_postal_code = self.selib.get_value(self.locator["postal_code_input_box"])

        # Compare values and raise assertions
        assert actual_first_name == first_name, f"First Name is not set properly. Expected: {first_name}, Actual: {actual_first_name}"
        assert actual_last_name == last_name, f"Last Name is not set properly. Expected: {last_name}, Actual: {actual_last_name}"
        assert actual_postal_code == postal_code, f"Postal code is not set properly. Expected: {postal_code}, Actual: {actual_postal_code}"

        # Proceed with continue
        self.selib.click_element(self.locator["continue_button"])

    def add_user_information(self, first_name, last_name, postal_code):
        self.selib.input_text(self.locator["first_name_input_box"], first_name)
        self.selib.input_text(self.locator["last_name_input_box"], last_name)
        self.selib.input_text(self.locator["postal_code_input_box"], postal_code)

    def proceed_with_continue_to_confirm_order_details(self):
        self.selib.click_element(self.locator["continue_button"])



