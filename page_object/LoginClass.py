import logging
import time

from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

from BaseClass import BaseClass


class LoginClass(BaseClass):
    _locators = {
        "user_name": "id=user-name",
        "password": "id=password",
        "login_button": "id=login-button",
        "inventory_title": "class=title",
        "login_error_button": "xpath=//div[@class='error-message-container error']",
    }

    def load_product_page_within_one_second_after_login(self, parameters_list):
        # Input username and password
        self.selib.input_text(self.locator["user_name"], parameters_list[3])
        self.selib.input_text(self.locator["password"], parameters_list[4])
        # Measure time to load product page after login
        start_time = int(round(time.time() * 1000))
        self.selib.click_element(self.locator["login_button"])
        # Wait for the presence of the inventory container
        WebDriverWait(self.browser, 10).until(
            EC.presence_of_element_located((By.ID, "inventory_container"))
        )
        end_time = int(round(time.time() * 1000))
        response_time = (end_time - start_time) / 1000
        logging.info(f"Response time: {response_time} seconds")
        assert response_time <= 1, "Page did not load within the given time"
