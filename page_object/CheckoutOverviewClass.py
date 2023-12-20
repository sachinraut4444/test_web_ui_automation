from BaseClass import BaseClass
import logging

from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time


class CheckoutOverviewClass(BaseClass):
    _locators = {
        "first_name_input_box": "id=first-name",
        "last_name_input_box": "id=last-name",
        "postal_code_input_box": "id=postal-code",
        "finish_button": "id=finish"
    }

    def verify_selected_product_on_checkout_page(self, product_data):

        try:
            cart_items = self.browser.find_elements(By.XPATH, "//div[@class='cart_list']//div[@class='cart_item']")

            product_dictionary_on_cart_page = {
                item.find_element(By.XPATH, ".//div[@class='inventory_item_name']").text: {
                    "product_quantity": item.find_element(By.XPATH, ".//div[@class='cart_quantity']").text,
                    "product_price": item.find_element(By.XPATH, ".//div[@class='inventory_item_price']").text
                }
                for item in cart_items
            }

            if product_dictionary_on_cart_page != product_data:
                raise Exception(
                    f"Dictionary Mismatch. Actual Product- {product_data} \n Expected Product - {product_dictionary_on_cart_page}")

        except TimeoutException as ex:
            logging.error("Timeout exception")



    def proceed_with_finish_order(self):
        self.selib.click_element(self.locator["finish_button"])
