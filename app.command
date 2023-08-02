#!/usr/bin/python3

import datetime
import sys
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
import time
import logging


def main(fullName, employeeNumber) -> bool:
    logging.info("clock-in process started " + str(datetime.datetime.now()))

    try:
        # Browser Window Object
        browser = webdriver.Chrome(
            service=Service(ChromeDriverManager(version="114.0.5735.90").install())
        )
        logging.info("Chrome Browser Opened")
    except BaseException:
        logging.info("Chrome Browser Failed to open")
        return False

    try:
        # Admin Form to fill in
        form = browser.get(
            "https://docs.google.com/forms/d/e/1FAIpQLSeAwbmMlARF5AhJzbDoVbtG075ZQBi_VLXBXPwTyak7GlJ4oA/viewform"
        )
        logging.info("Google Form Opened")
    except BaseException:
        logging.info("Google Form Failed to Open")
        return False

    try:
        inputs = browser.find_elements(By.TAG_NAME, "input")
        count = 0
        for index, inputTag in enumerate(inputs):
            time.sleep(1)
            if inputTag.get_attribute("type") == "text" and count == 0:
                inputTag.send_keys(fullName)
                logging.info("Username Entered")
                count += 1
            elif inputTag.get_attribute("type") == "text" and count == 1:
                inputTag.send_keys(employeeNumber)
                logging.info("Employee Number Entered")
                count += 1

        buttons = browser.find_elements(By.TAG_NAME, "div")

        for button in buttons:
            if button.get_attribute("role") == "button":
                button.click()
                logging.info("Submitted Successfully")

    except BaseException as error:
        logging.info("Failed to submit" + str(error))
        return False

    time.sleep(2)
    return True


if __name__ == "__main__":
    # If process args aren't the right length
    if len(sys.argv) != 3:
        print("Employee Name and Number not provided")

    logging.basicConfig(filename="clockin.log", encoding="utf-8", level=logging.INFO)

    if main(sys.argv[1], sys.argv[2]):
        print("Clocked In")
    else:
        print("Error Encountered")