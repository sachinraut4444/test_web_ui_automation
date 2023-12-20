from BaseClass import BaseClass
import logging
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time

class InventoryClass(BaseClass):

    _locators = {
        "inventory_container": "id=inventory_container",
        "product_title": "class=title",
        "shopping_cart": "class=shopping_cart_link",
        "sort_icon": "class=product_sort_container",
        "product_name": "//div[@class='inventory_item'][1]//div[@class='inventory_item_name']"
    }

    def select_product_on_inventory_page(self, product_name):
        product_items = self.browser.find_elements(By.XPATH,
                                                   "//div[@class='inventory_list']//div[@class='inventory_item']")

        for index, product_item in enumerate(product_items, start=1):
            product_name_xpath = f"{self.get_product_xpath(index)}//div[@class='inventory_item_name ']"
            product_name_text = product_item.find_element(By.XPATH, product_name_xpath).text

            if product_name == product_name_text:
                add_cart_button_xpath = f"{self.get_product_xpath(index)}//button"
                product_item.find_element(By.XPATH, add_cart_button_xpath).click()

    def get_product_xpath(self, index):
        return f"//div[@class='inventory_list']//div[@class='inventory_item'][{index}]"

    def verify_selected_product_count_on_inventory_page(self):
        selected_product_xpath = self.browser.find_elements(By.XPATH, "//button[contains(@data-test,'remove-')]")
        shipping_cart_product_count = self.browser.find_element(By.CLASS_NAME, "shopping_cart_badge").text
        logging.info(f"{len(selected_product_xpath)}, {shipping_cart_product_count} ")
        assert len(selected_product_xpath) == int(shipping_cart_product_count), "Selected Product Mismatch with Add to cart"
