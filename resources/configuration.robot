*** Settings ***
Documentation	This file used to maintain parameters used globaly in setup

*** Variables ***
${host}                     https://www.saucedemo.com/
${browser}                  Chrome
${standard_user}            standard_user
${locked_out_user}          locked_out_user
${problem_user}             problem_user
${performance_glitch_user}  performance_glitch_user
${error_user}               error_user
${visual_user}              visual_user
${user_password}            secret_sauce
${headless}                 False
${user_first_name}          Sachin
${user_last_name}           Raut
${postal_code}              411014

@{parameters_Login}	    ${host}	    ${browser}      ${headless}     ${standard_user}        ${user_password}
@{locked_user_parameters_Login}     ${host}	    ${browser}      ${headless}     ${locked_out_user}        ${user_password}
@{problem_user_parameters_Login}     ${host}	    ${browser}      ${headless}     ${problem_user}        ${user_password}
@{performance_glitch_user_parameters_Login}     ${host}	    ${browser}      ${headless}     ${performance_glitch_user}        ${user_password}
@{error_user_parameters_Login}     ${host}	    ${browser}      ${headless}     ${error_user}        ${user_password}
@{visual_user_parameters_Login}     ${host}	    ${browser}      ${headless}     ${visual_user}        ${user_password}
