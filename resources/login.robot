*** Settings ***
Documentation     This file has login scenarios

Resource    ../page_object/lib_page_object.robot
Library         SeleniumLibrary

*** Keywords ***
Login to application
	[Arguments]	    ${parameters}
	Navigate to url     ${parameters}[0]    ${parameters}[1]    ${parameters}[2]
	LoginClass.Enter Text In Input Box     user_name       ${parameters}[3]
	LoginClass.Enter text in input box     password       ${parameters}[4]
	LoginClass.Click element on page locator       login_button
	Sleep       10s


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
    ELSE
       open browser	${URL}	    ${BROWSER}
    END
	Set Window Size	     1536       864
    Set Selenium Implicit Wait      5s

exit browser
	RUN KEYWORD AND CONTINUE ON FAILURE	    close browser