from BaseClass import BaseClass


class LoginClass(BaseClass):

    _locators = {
        "user_name": "id=user-name",
        "password": "id=password",
        "login_button": "id=login-button",
        "inventory_title": "class= title"
    }
