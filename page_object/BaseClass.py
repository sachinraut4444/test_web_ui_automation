import logging
import traceback

from datetime import datetime
from PageObjectLibrary import PageObject
from pytz import timezone
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import ElementClickInterceptedException, NoSuchElementException, TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.wait import WebDriverWait

IST = timezone("Asia/Kolkata")


class BaseClass(PageObject):
    _locators = {
        "user_name1": "id=user-name",
        "checkout_button": "id=checkout",
        "continue_button": "id=continue",
    }

    def __init__(self):
        super().__init__()

    def check_visible_and_return_status(self, element_xpath, timeout=0.5):
        try:
            WebDriverWait(self.browser, timeout).until(
                EC.visibility_of_element_located((By.XPATH, element_xpath)))
            return True
        except TimeoutException:
            return False
    def clear_input_box_text(self, locator_name):
        try:
            element_locator = str(self.locator[locator_name])
            element_locator_value = self.find_web_element(element_locator)

            # Ensure the element is present before interacting with it
            if element_locator_value:
                element_locator_value.send_keys(Keys.CONTROL + "a")
                element_locator_value.send_keys(Keys.BACKSPACE)
            else:
                print(f"Element with locator '{locator_name}' not found.")
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            self.log_exception("clear_input_box_text", str(ex))
            raise

    def click_element_on_page_locator(self, locator_name):
        try:
            element_locator_value = str(self.locator[locator_name])
            self.selib.click_element(element_locator_value)
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            self.log_exception("click_element_on_page_locator", str(ex))
            raise

    def enter_text_in_input_box(self, locator_name, user_text):
        try:
            element_locator_value = str(self.locator[locator_name])
            self.selib.input_text(element_locator_value, user_text)
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            self.log_exception("enter_text_in_input_box", str(ex))
            raise

    def find_web_element(self, input_string):
        try:
            split_result = input_string.split("=", 1)
            strategy = split_result[0].strip()
            value = split_result[1].strip()
            if strategy.lower() == "id":
                return self.browser.find_element(By.ID, value)
            elif strategy.lower() == "name":
                return self.browser.find_element(By.NAME, value)
            elif strategy.lower() == "class":
                return self.browser.find_element(By.CLASS_NAME, value)
            elif strategy.lower() == "xpath":
                return self.browser.find_element(By.XPATH, value)
            elif strategy.lower() == "css":
                return self.browser.find_element(By.CSS_SELECTOR, value)
            else:
                raise ValueError(f"Unsupported locator strategy: {strategy}")
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            self.log_exception("find_web_element", str(ex))
            raise

    def get_element_text(self, locator_name):
        try:
            element_locator = str(self.locator[locator_name])
            element_locator_value = self.find_web_element(element_locator)
            self.selib.wait_until_element_is_visible(element_locator_value, timeout=10)
            locator_text = self.selib.get_text(element_locator_value)
            return locator_text
        except NoSuchElementException as ex:
            self.log_exception("get_element_text", str(ex))
            raise
        except TimeoutException as ex:
            self.log_exception("clear_input_box_text", str(ex))
            raise
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            self.log_exception("clear_input_box_text", str(ex))
            raise

    def get_product_name_path(self, product_name):
        return f"//DIV[@class='inventory_item_name'][text()='{product_name}']"

    def move_to_specific_element(self, element_xpath):
        try:
            element = self.find_web_element(element_xpath)
            self.browser.execute_script("arguments[0].scrollIntoView();", element)
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            self.log_exception("move_to_specific_element", str(ex))
            raise

    def log_exception(self, method_name, exception):
        logging.error(f"Exception raised for method: {method_name}() {exception}")
        self.browser.save_screenshot(
            f"selenium-screenshot-{method_name}-{datetime.now(IST)}.png")
        logging.info(f"Traceback Error information -> {traceback.format_exc()}")

    def return_element_page_locator(self, locator_name):
        try:
            element_locator_value = str(self.locator[locator_name])
            return element_locator_value
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            self.log_exception("return_element_page_locator", str(ex))
            raise

    def wait_until_element_visible_on_page(self, locator_name):
        try:
            element_locator_value = str(self.locator[locator_name])
            self.selib.wait_until_element_is_visible(element_locator_value, timeout=1)
        except (TimeoutException, ElementClickInterceptedException, NoSuchElementException) as ex:
            self.log_exception("wait_until_element_visible_on_page", str(ex))
            raise
