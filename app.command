#!/usr/bin/python3

import datetime
import sys
import time
import logging
from pyppeteer import launch
import asyncio


async def main(fullName, employeeNumber) -> bool:
    logging.info("clock-in process started " + str(datetime.datetime.now()))
    try:
        # Browser Window Object
        browser = await launch({"headless": False})
        logging.info("Chrome Browser Opened")
    except BaseException:
        logging.info("Chrome Browser Failed to open")
        await browser.close()
        return False

    try:
        # Admin Form to fill in
        form = await browser.newPage()
        await form.goto(
            "https://docs.google.com/forms/d/e/1FAIpQLSeAwbmMlARF5AhJzbDoVbtG075ZQBi_VLXBXPwTyak7GlJ4oA/viewform"
        )
        logging.info("Google Form Opened")
    except BaseException:
        logging.info("Google Form Failed to Open")
        await browser.close()
        return False

    try:
        time.sleep(1)
        inputs = await form.querySelector('input[aria-describedby="i2 i3"]')
        await inputs.type(fullName)
        logging.info("Username Entered")
        time.sleep(1)
        inputs = await form.querySelector('input[aria-describedby="i6 i7"]')
        await inputs.type(employeeNumber)
        logging.info("Employee Number Entered")
        time.sleep(1)
        buttons = await form.querySelector("div[role='button']")
        await buttons.click()
        logging.info("Submitted Successfully")
        time.sleep(2)
        await browser.close()
    except BaseException as error:
        logging.error("Failed to submit" + str(error))
        await browser.close()
        return False


if __name__ == "__main__":
    # If process args aren't the right length
    if len(sys.argv) != 3:
        print("Employee Name and Number not provided")

    logging.basicConfig(filename="clockin.log", encoding="utf-8", level=logging.INFO)

    if asyncio.get_event_loop().run_until_complete(main(sys.argv[1], sys.argv[2])):
        print("Clocked In")
    else:
        print("Error Encountered")
