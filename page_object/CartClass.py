import logging

from selenium.common.exceptions import ElementClickInterceptedException, NoSuchElementException, TimeoutException
from selenium.webdriver.common.by import By

from BaseClass import BaseClass


class CartClass(BaseClass):
    _locators = {
        "product_title": "class=title",
        "shopping_cart": "class=shopping_cart_link",
        "checkout_button": "id=checkout",
        "continue_shopping_button": "id=continue-shopping",
    }

    def navigate_to_product_page_from_cart_section(self):
        try:
            self.selib.click_element(self.locator["continue_shopping_button"])
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            BaseClass.log_exception(self, "navigate_to_product_page_from_cart_section", str(ex))
            raise

    def proceed_with_checkout_from_cart_page(self):
        try:
            self.selib.click_element(self.locator["checkout_button"])
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            BaseClass.log_exception(self, "navigate_to_product_page_from_cart_section", str(ex))
            raise

    def unselect_product_on_cart_page(self, product_name, remove_product=True):
        try:
            product_items = self.browser.find_elements(
                By.XPATH, "//div[@class='cart_list']//div[@class='cart_item']"
            )

            for index, product_item in enumerate(product_items, start=1):
                product_name_xpath = f"//div[@class='cart_list']//div[@class='cart_item'][{(index)}]//div[@class='inventory_item_name']"
                product_name_text = product_item.find_element(
                    By.XPATH, product_name_xpath
                ).text

                if product_name == product_name_text:
                    if remove_product:
                        add_cart_button_xpath = f"//div[@class='cart_list']//div[@class='cart_item'][{(index)}]//button"
                        product_item.find_element(By.XPATH, add_cart_button_xpath).click()
                        break
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            BaseClass.log_exception(self, "unselect_product_on_cart_page", str(ex))
            raise

    def verify_displayed_product_count_with_shopping_cart_count(self):
        try:
            selected_product_elements = self.browser.find_elements(
                By.XPATH, "//button[contains(@data-test,'remove-')]"
            )
            shopping_cart_product_count = self.browser.find_element(
                By.CLASS_NAME, "shopping_cart_link"
            ).text

            selected_product_count = len(selected_product_elements)
            logging.info(
                f"Selected Product Count: {selected_product_count}, Shopping Cart Product Count: {shopping_cart_product_count}"
            )

            if selected_product_count != 0:
                assert selected_product_count == int(
                    shopping_cart_product_count
                ), "Selected Product Mismatch with Add to cart"
            elif len(shopping_cart_product_count) != 0:
                assert False, "Unexpected Shopping Cart Product Count"
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            BaseClass.log_exception(self, "verify_displayed_product_count_with_shopping_cart_count", str(ex))
            raise

    def verify_selected_product_on_cart_page(self, product_data):
        try:
            cart_items = self.browser.find_elements(
                By.XPATH, "//div[@class='cart_list']//div[@class='cart_item']"
            )

            product_dictionary_on_cart_page = {
                item.find_element(
                    By.XPATH, ".//div[@class='inventory_item_name']"
                ).text: {
                    "product_quantity": item.find_element(
                        By.XPATH, ".//div[@class='cart_quantity']"
                    ).text,
                    "product_price": item.find_element(
                        By.XPATH, ".//div[@class='inventory_item_price']"
                    ).text,
                }
                for item in cart_items
            }

            if product_dictionary_on_cart_page != product_data:
                raise Exception(
                    f"Dictionary Mismatch. Actual Product- {product_data} \n Expected Product - {product_dictionary_on_cart_page}"
                )
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            BaseClass.log_exception(self, "verify_selected_product_on_cart_page", str(ex))
            raise
