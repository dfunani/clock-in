#!/usr/bin/python3

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
import time
# Browser Window Object
browser = webdriver.Chrome(service=Service(ChromeDriverManager(version="114.0.5735.90").install()))

# Admin Form to fill in
form = browser.get("https://docs.google.com/forms/d/e/1FAIpQLSeAwbmMlARF5AhJzbDoVbtG075ZQBi_VLXBXPwTyak7GlJ4oA/viewform")


try:
    inputs = browser.find_elements(By.TAG_NAME, 'input')
    count = 0
    for index, inputTag in enumerate(inputs):
        time.sleep(1)
        if inputTag.get_attribute("type") == "text" and count == 0:
            inputTag.send_keys("Delali Funani")
            count += 1
        elif inputTag.get_attribute("type") == "text" and count == 1:
            inputTag.send_keys("0851")
            count += 1
            
            
    buttons = browser.find_elements(By.TAG_NAME, "div")

    for button in buttons:
        if button.get_attribute("role") == "button":
            button.click()
            
    print("Submitted")
            
except BaseException:
    print("Submitted")

        
time.sleep(2)