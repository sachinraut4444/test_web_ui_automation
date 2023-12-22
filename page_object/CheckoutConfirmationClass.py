import logging
import time

from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

from BaseClass import BaseClass
class CheckoutConfirmationClass(BaseClass):
    _locators = {
        "order_confirmation_text_xpath": "class=complete-header",
        "back_to_home_button": "id=back-to-products",
    }
    def navigate_to_product_list_page_after_confirming_order(self):
        self.selib.click_element(self.locator["back_to_home_button"])

    def verify_order_confirmation_message(self):
        actual_text = self.selib.get_text(self.locator["order_confirmation_text_xpath"])
        expected_confirmation_text = "Thank you for your order!"
        assert actual_text == expected_confirmation_text
