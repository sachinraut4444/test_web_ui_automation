*** Settings ***
Documentation     This file has Browser related scenarios

Resource    ../page_object/lib_page_object.robot
Resource    ../resources/lib_resource.robot
Library         SeleniumLibrary

*** Keywords ***

navigate to url
	[Arguments]	    ${URL}	    ${BROWSER}     ${headless}
    open local browser	    ${URL}	    ${BROWSER}	    ${headless}

open local browser
	[Arguments]	    ${URL}	    ${BROWSER}      ${headless}
	IF  '${headless}'== 'True'
        ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
        Call Method    ${chrome_options}   add_argument    headless
        Call Method    ${chrome_options}   add_argument    disable-gpu
        Call Method    ${chrome_options}   add_argument    no-sandbox
        Call Method    ${chrome_options}   add_argument    disable-dev-shm-usage
	    open browser	${URL}	    ${BROWSER}    options=${chrome_options}
	    LoginClass.Wait until element visible on page       login_button
    ELSE
       open browser	${URL}	    ${BROWSER}
       LoginClass.Wait until element visible on page       login_button
    END
	Set Window Size	     1536       864
    #Set Selenium Implicit Wait      5s

exit browser
	RUN KEYWORD AND CONTINUE ON FAILURE	    close browser