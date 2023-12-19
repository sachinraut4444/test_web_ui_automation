from PageObjectLibrary import PageObject
from selenium.webdriver.support.wait import WebDriverWait


class BaseClass(PageObject):

    _locators = {
        "user_name1": "id=user-name",
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
        self.selib.wait_until_element_is_visible(element_locator_value, timeout=10)

    def get_element_text(self, locator_name):
        element_locator_value = str(self.locator[locator_name])
        locator_text = self.selib.get_text(element_locator_value)
        return locator_text
