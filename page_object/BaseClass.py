from PageObjectLibrary import PageObject
import logging
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import TimeoutException

class BaseClass(PageObject):

    _locators = {
        "user_name1": "id=user-name",
        "checkout_button": "id=checkout",
        "continue_button": "id=continue",
    }

    def __init__(self):
        super().__init__()

    def click_element_on_page_locator(self, locator_name):
        element_locator_value = str(self.locator[locator_name])
        self.selib.click_element(element_locator_value)

    def enter_text_in_input_box(self, locator_name, user_text):
        element_locator_value = str(self.locator[locator_name])
        self.selib.input_text(element_locator_value, user_text)

    def return_element_page_locator(self, locator_name):
        element_locator_value = str(self.locator[locator_name])
        return element_locator_value

    def wait_until_element_visible_on_page(self, locator_name):
        element_locator_value = str(self.locator[locator_name])
        self.selib.wait_until_element_is_visible(element_locator_value, timeout=1)

    def get_element_text(self, locator_name):
        element_locator = str(self.locator[locator_name])
        element_locator_value = self.find_web_element(element_locator)
        self.selib.wait_until_element_is_visible(element_locator_value, timeout=10)
        locator_text = self.selib.get_text(element_locator_value)
        return locator_text

    def clear_input_box_text(self, locator_name):
        element_locator = str(self.locator[locator_name])
        element_locator_value = self.find_web_element(element_locator)
        element_locator_value.send_keys(Keys.CONTROL + 'a')
        element_locator_value.send_keys(Keys.BACKSPACE)

    def find_web_element(self, input_string):
        split_result = input_string.split('=', 1)
        strategy = split_result[0].strip()
        value = split_result[1].strip()
        if strategy.lower() == 'id':
            return self.browser.find_element(By.ID, value)
        elif strategy.lower() == 'name':
            return self.browser.find_element(By.NAME, value)
        elif strategy.lower() == 'class':
            return self.browser.find_element(By.CLASS_NAME, value)
        elif strategy.lower() == 'xpath':
            return self.browser.find_element(By.XPATH, value)
        elif strategy.lower() == 'css':
            return self.browser.find_element(By.CSS_SELECTOR, value)
        else:
            raise ValueError(f"Unsupported locator strategy: {strategy}")

    def move_to_specific_element(self, element_xpath):
        try:
            element = self.find_web_element(element_xpath)
            self.browser.execute_script("arguments[0].scrollIntoView();", element)
        except TimeoutException as ex:
            logging.error("Exception raised")

    def get_product_name_path(self, product_name):
        return f"//DIV[@class='inventory_item_name'][text()='{product_name}']"
