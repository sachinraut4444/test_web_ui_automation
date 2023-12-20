from BaseClass import BaseClass
import logging

from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time


class CartClass(BaseClass):
    _locators = {
        "product_title": "class=title",
        "shopping_cart": "class=shopping_cart_link",
        "checkout_button": "id=checkout"
    }

    def verify_selected_product_on_cart_page(self, product_data):
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

    def proceed_with_checkout_from_cart_page(self):
        self.selib.click_element(self.locator["checkout_button"])
