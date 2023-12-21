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

        self.selib.input_text(self.locator["first_name_input_box"], first_name)
        self.selib.input_text(self.locator["last_name_input_box"], last_name)
        self.selib.input_text(self.locator["postal_code_input_box"], postal_code)
        self.selib.click_element(self.locator["continue_button"])

    def proceed_with_continue_to_confirm_order_details(self):
        self.selib.click_element(self.locator["continue_button"])



