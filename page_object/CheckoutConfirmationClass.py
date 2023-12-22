from selenium.common.exceptions import ElementClickInterceptedException, NoSuchElementException, TimeoutException

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
