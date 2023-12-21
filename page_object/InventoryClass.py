from BaseClass import BaseClass

from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoSuchElementException, TimeoutException
import logging
from selenium.webdriver.common.keys import Keys
import time


class InventoryClass(BaseClass):

    _locators = {
        "inventory_container": "id=inventory_container",
        "product_title": "class=title",
        "shopping_cart": "class=shopping_cart_link",
        "sort_icon": "class=product_sort_container",
        "side_menu_open_button": "id=react-burger-menu-btn",
        "side_menu_all_item_button": "id= inventory_sidebar_link",
        "side_menu_about_button": "id= about_sidebar_link",
        "side_menu_logout_button": "id= logout_sidebar_link",
        "side_menu_reset_button": "id= reset_sidebar_link",
        "side_menu_close_button": "id=react-burger-cross-btn",
        "product_name": "//div[@class='inventory_item'][1]//div[@class='inventory_item_name']",
        "remove_single_product_from_detail_view": "xpath=//button[contains(text(), 'Remove')]"
    }

    def get_inventory_element_locator(self, locator_name):
        return self.locator[locator_name]

    def click_element_on_inventory_page(self, locator_name):
        element_locator_value = str(self.locator[locator_name])
        self.selib.wait_until_element_is_visible(element_locator_value)
        self.selib.click_element(element_locator_value)

    def check_element_visible_inventory_on_page(self, locator_name):
        element_locator_value = str(self.locator[locator_name])
        self.selib.wait_until_element_is_visible(element_locator_value)

    def select_unselect_product_on_inventory_page(self, product_name, add_product=True):
        product_items = self.browser.find_elements(By.XPATH,
                                                   "//div[@class='inventory_list']//div[@class='inventory_item']")

        for index, product_item in enumerate(product_items, start=1):
            product_name_xpath = f"{self.get_product_xpath(index)}//div[@class='inventory_item_name ']"
            product_name_text = product_item.find_element(By.XPATH, product_name_xpath).text

            if product_name == product_name_text:
                if add_product:
                    try:
                        add_cart_button_xpath = f"{self.get_product_xpath(index)}//button"
                        product_item.find_element(By.XPATH, add_cart_button_xpath).click()
                        remove_button_xpath = f"{self.get_product_xpath(index)}//button[contains(text(), 'Remove')]"
                        logging.info(f"remove_button_xpath {remove_button_xpath}")
                        wait_time = 2
                        WebDriverWait(self.browser, wait_time).until(
                            EC.visibility_of_element_located((By.XPATH, remove_button_xpath))
                        )
                    except TimeoutException:
                        raise TimeoutError(f"Failed to add Product into cart ")
                else:
                    try:
                        add_cart_button_xpath = f"{self.get_product_xpath(index)}//button"
                        product_item.find_element(By.XPATH, add_cart_button_xpath).click()
                    except TimeoutException:
                        raise TimeoutError(f"Failed to remove Product")

    def get_all_product_name_and_price_from_inventory_page(self):

        product_name_price_dict = {}
        product_items = self.browser.find_elements(By.XPATH,
                                                   "//div[@class='inventory_list']//div[@class='inventory_item']")

        for index, product_item in enumerate(product_items, start=1):
            product_name_xpath = f"{self.get_product_xpath(index)}//div[@class='inventory_item_name ']"
            product_price_xpath = f"{self.get_product_xpath(index)}//div[@class='inventory_item_price']"
            product_name_text = product_item.find_element(By.XPATH, product_name_xpath).text
            product_price = product_item.find_element(By.XPATH, product_price_xpath).text
            product_name_price_dict[product_name_text] = product_price

        return product_name_price_dict

    def get_product_xpath(self, index):
        return f"//div[@class='inventory_list']//div[@class='inventory_item'][{index}]"

    def verify_selected_product_count_with_shopping_cart_count(self):
        selected_product_elements = self.browser.find_elements(By.XPATH, "//button[contains(@data-test,'remove-')]")
        shopping_cart_product_count = self.browser.find_element(By.CLASS_NAME, "shopping_cart_link").text

        selected_product_count = len(selected_product_elements)
        logging.info(
            f"Selected Product Count: {selected_product_count}, Shopping Cart Product Count: {shopping_cart_product_count}")

        if selected_product_count != 0:
            assert selected_product_count == int(
                shopping_cart_product_count), "Selected Product Mismatch with Add to cart"
        elif len(shopping_cart_product_count) != 0:
            assert False, "Unexpected Shopping Cart Product Count"

    def proceed_to_view_item_on_cart_page(self):
        self.selib.click_element(self.locator["shopping_cart"])

    def verify_respective_image_display_for_product_on_inventory_page(self):
        product_items = self.browser.find_elements(By.XPATH,
                                                   "//div[@class='inventory_list']//div[@class='inventory_item']")
        image_url_list = []
        for index, product_item in enumerate(product_items, start=1):
            product_image_xpath = f"{self.get_product_xpath(index)}//div[@class='inventory_item_img']//img"
            product_image_url = product_item.find_element(By.XPATH, product_image_xpath).get_attribute("src").split("media")[1]
            image_url_list.append(product_image_url)
        image_url_list = list(set(image_url_list))
        assert len(product_items) == len(image_url_list), "Product Image is not matching"
