*** Settings ***
Documentation	This file used to maintain parameters used globaly in setup

*** Variables ***
${host}                     https://www.saucedemo.com/
${browser}                  Chrome
${standard_user}            standard_user
${user_password}            secret_sauce
${headless}                 False

@{parameters_Login}	    ${host}	    ${browser}      ${headless}     ${standard_user}        ${user_password}
