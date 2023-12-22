import time
from selenium.common.exceptions import ElementClickInterceptedException, NoSuchElementException, TimeoutException

from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

from BaseClass import BaseClass


class CheckoutConfirmationClass(BaseClass):
    _locators = {
        "order_confirmation_text_xpath": "class=complete-header",
        "back_to_home_button": "id=back-to-products",
    }

    def navigate_to_product_list_page_after_confirming_order(self):
        try:
            self.selib.click_element(self.locator["back_to_home_button"])
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            BaseClass.log_exception(self, "navigate_to_product_page_from_cart_section", str(ex))
            raise

    def verify_order_confirmation_message(self):
        try:
            actual_text = self.selib.get_text(self.locator["order_confirmation_text_xpath"])
            expected_confirmation_text = "Thank you for your order!"
            assert actual_text == expected_confirmation_text
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            BaseClass.log_exception(self, "navigate_to_product_page_from_cart_section", str(ex))
            raise

    def load_product_detail_page_within_one_second_after_confirming_order(self):
        first_default_product_xpath = "//div[@class='inventory_list']//div[@class='inventory_item'][1]//DIV[@class='inventory_item_name '][text()='Sauce Labs Backpack']"
        try:
            start_time = int(round(time.time() * 1000))
            self.selib.click_element(self.locator["back_to_home_button"])
            # Wait for the first default product to appear
            WebDriverWait(self.browser, 60).until(
                EC.presence_of_element_located((By.XPATH, first_default_product_xpath))
            )
            end_time = int(round(time.time() * 1000))
            response_time = (end_time - start_time) / 1000
            assert (
                    response_time <= 1
            ), "Product List page did not load within the given time"
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            BaseClass.log_exception(self, "load_product_detail_page_within_one_second_after_confirming_order", str(ex))
            raise
