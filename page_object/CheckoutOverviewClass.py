from BaseClass import BaseClass
import logging

from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time


class CheckoutOverviewClass(BaseClass):
    _locators = {
        "finish_button": "id=finish",
        "total_price_element": "xpath=//div[@class='summary_info_label summary_total_label']",
        "sub_total_price_element": "xpath=//div[@class='summary_subtotal_label']",
        "total_tax_element": "xpath=//div[@class='summary_tax_label']",
        "payment_information_element": "xpath=//div[contains(text(), 'Payment Information')]//following::div[1]",
        "shipping_information_element": "xpath=//div[contains(text(), 'Shipping Information')]//following::div[1]",
        "cancel_button": "id=cancel",
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

    def verify_total_price_of_selected_product(self, product_data):
        actual_total_price_of_product = float(BaseClass.get_element_text(self, "total_price_element").split("$")[1])
        total_tax_on_selected_product = float(BaseClass.get_element_text(self, "total_tax_element").split("$")[1])
        sub_total_price = self.get_item_total_price_of_selected_product(product_data)
        expected_total_price_of_product = round(sub_total_price + total_tax_on_selected_product, 2)
        assert expected_total_price_of_product == actual_total_price_of_product

    def get_item_total_price_of_selected_product(self, product_data):
        total_price = 0.0
        for product, data in product_data.items():
            quantity = int(data['product_quantity'])
            price = float(data['product_price'].replace('$', ''))  # Remove '$' and convert to float
            total_price += quantity * price

        return total_price

    def proceed_with_cancel_from_confirm_order_page(self):
        self.selib.click_element(self.locator["cancel_button"])