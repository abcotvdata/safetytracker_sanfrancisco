library(RSelenium)
library(tidyverse)
library(magick)
library(tesseract)
library(lubridate)

# OPEN WORK TO AUTOMATE THIS STEP
# SEEMS TO UPDATE OVERNIGHT MONDAY/TUESDAY

# Sets a series of URLs for each police district in SFPD's tableau
urlSF <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile"
urlBayview <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile?DISTRICT=Bayview"
urlCentral <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile?DISTRICT=Central"
urlIngleside <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile?DISTRICT=Ingleside"
urlMission <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile?DISTRICT=Mission"
urlNorthern <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile?DISTRICT=Northern"
urlPark <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile?DISTRICT=Park"
urlRichmond <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile?DISTRICT=Richmond"
urlSouthern <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile?DISTRICT=Southern"
urlTaraval <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile?DISTRICT=Taraval"
urlTenderloin <- "https://public.tableau.com/app/profile/san.francisco.police.department/viz/CrimeNumbersDashboardMobile/Crime_Numbers_Mobile?DISTRICT=Tenderloin"

# set start date for newest period we need to capture
# in this case 365 days prior to the newest data we have to calculate 'last 12 mos' figures
sf_tableau_update <- readRDS("scripts/rds/sf_tableau_update.rds")
startdate <- format(sf_tableau_update-364,"%m/%d/%Y")
# set start date for newest period we need to capture, IF NEEDED
enddate <- paste0("12/31/",year(sf_tableau_update-364))

# Launch browser and driver
rD <- rsDriver(browser="firefox", port=4545L, verbose=F)
remDr <- rD[["client"]]

# For the series of urls, we navigate to each, scroll down and take the same screenshot
remDr$navigate(urlSF)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 500)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/SFScreen_date.png")

remDr$navigate(urlSF)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/SFScreen.png")

remDr$navigate(urlBayview)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/BayviewScreen.png")

remDr$navigate(urlCentral)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/CentralScreen.png")

remDr$navigate(urlIngleside)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/InglesideScreen.png")

remDr$navigate(urlMission)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/MissionScreen.png")

remDr$navigate(urlNorthern)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/NorthernScreen.png")

remDr$navigate(urlPark)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/ParkScreen.png")

remDr$navigate(urlRichmond)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/RichmondScreen.png")

remDr$navigate(urlSouthern)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/SouthernScreen.png")

remDr$navigate(urlTaraval)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/TaravalScreen.png")

remDr$navigate(urlTenderloin)
Sys.sleep(3)   # slight delay to let page load
# content is in iframe; find it and switch to it
frames <- remDr$findElements("css", "iframe")
remDr$switchToFrame(frames[[1]])
# this finds the start date input box, deletes the text and enters startdate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 1]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",startdate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# repeat for enddate: finds element, deletes text and enters enddate variable 
remDr$findElement('xpath', '//*[@id="typein_[Parameters].[Parameter 2]"]/span[1]/input')$sendKeysToElement(list(key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",key="backspace",enddate,key="enter"))
Sys.sleep(3)   # slight delay to let page load
# switch back to main window before scrolling to get image of data
windows_handles <- remDr$getWindowHandles()
Sys.sleep(2)
remDr$switchToWindow(windows_handles[[1]])
remDr$executeScript("scrollBy(0, 1300)") # scrolls to numbers
remDr$screenshot(display = FALSE, useViewer = FALSE, file = "data/source/images/TenderloinScreen.png")

# we have the screen images we need
# closes server connection to browser
rD$server$stop()

### CONVERT AND OCR IMAGES INTO COLS OF DATA
# This reads the image of the screen cap
SF_screenimage_date <- image_read("data/source/images/SFScreen_date.png")
SF_screenimage <- image_read("data/source/images/SFScreen.png")
Bayview_screenimage <- image_read("data/source/images/BayviewScreen.png")
Central_screenimage <- image_read("data/source/images/CentralScreen.png")
Ingleside_screenimage <- image_read("data/source/images/InglesideScreen.png")
Mission_screenimage <- image_read("data/source/images/MissionScreen.png")
Northern_screenimage <- image_read("data/source/images/NorthernScreen.png")
Park_screenimage <- image_read("data/source/images/ParkScreen.png")
Richmond_screenimage <- image_read("data/source/images/RichmondScreen.png")
Southern_screenimage <- image_read("data/source/images/SouthernScreen.png")
Taraval_screenimage <- image_read("data/source/images/TaravalScreen.png")
Tenderloin_screenimage <- image_read("data/source/images/TenderloinScreen.png")

# Capture the numbers from each cell in the viewable table
# We are following this approach to carefully map values to crimes
# And to ensure we account for cells that are zero but SFPD shows blank
# date first
SF_update <- image_crop(SF_screenimage_date, "400x70+1265+460")
# crime data for all
SF_title1 <- image_crop(SF_screenimage, "200x105+940+112")
SF_title2 <- image_crop(SF_screenimage, "200x105+940+224")
SF_title3 <- image_crop(SF_screenimage, "200x105+940+336")
SF_title4 <- image_crop(SF_screenimage, "200x105+940+448")
SF_title5 <- image_crop(SF_screenimage, "200x105+940+560")
SF_title6 <- image_crop(SF_screenimage, "200x105+940+672")
SF_title7 <- image_crop(SF_screenimage, "200x105+940+784")
SF_title8 <- image_crop(SF_screenimage, "200x105+940+896")
SF_title9 <- image_crop(SF_screenimage, "200x105+940+1008")
SF_title10 <- image_crop(SF_screenimage, "200x105+940+1120")
SF_title11 <- image_crop(SF_screenimage, "200x105+940+1232")
SF_title12 <- image_crop(SF_screenimage, "200x105+940+1344")
SF_thisyear1 <- image_crop(SF_screenimage, "200x105+1160+112")
SF_thisyear2 <- image_crop(SF_screenimage, "200x105+1160+224")
SF_thisyear3 <- image_crop(SF_screenimage, "200x105+1160+336")
SF_thisyear4 <- image_crop(SF_screenimage, "200x105+1160+448")
SF_thisyear5 <- image_crop(SF_screenimage, "200x105+1160+560")
SF_thisyear6 <- image_crop(SF_screenimage, "200x105+1160+672")
SF_thisyear7 <- image_crop(SF_screenimage, "200x105+1160+784")
SF_thisyear8 <- image_crop(SF_screenimage, "200x105+1160+896")
SF_thisyear9 <- image_crop(SF_screenimage, "200x105+1160+1008")
SF_thisyear10 <- image_crop(SF_screenimage, "200x105+1160+1120")
SF_thisyear11 <- image_crop(SF_screenimage, "200x105+1160+1232")
SF_thisyear12 <- image_crop(SF_screenimage, "200x105+1160+1344")
Bayview_title1 <- image_crop(Bayview_screenimage, "200x105+940+112")
Bayview_title2 <- image_crop(Bayview_screenimage, "200x105+940+224")
Bayview_title3 <- image_crop(Bayview_screenimage, "200x105+940+336")
Bayview_title4 <- image_crop(Bayview_screenimage, "200x105+940+448")
Bayview_title5 <- image_crop(Bayview_screenimage, "200x105+940+560")
Bayview_title6 <- image_crop(Bayview_screenimage, "200x105+940+672")
Bayview_title7 <- image_crop(Bayview_screenimage, "200x105+940+784")
Bayview_title8 <- image_crop(Bayview_screenimage, "200x105+940+896")
Bayview_title9 <- image_crop(Bayview_screenimage, "200x105+940+1008")
Bayview_title10 <- image_crop(Bayview_screenimage, "200x105+940+1120")
Bayview_title11 <- image_crop(Bayview_screenimage, "200x105+940+1232")
Bayview_title12 <- image_crop(Bayview_screenimage, "200x105+940+1344")
Bayview_thisyear1 <- image_crop(Bayview_screenimage, "200x105+1160+112")
Bayview_thisyear2 <- image_crop(Bayview_screenimage, "200x105+1160+224")
Bayview_thisyear3 <- image_crop(Bayview_screenimage, "200x105+1160+336")
Bayview_thisyear4 <- image_crop(Bayview_screenimage, "200x105+1160+448")
Bayview_thisyear5 <- image_crop(Bayview_screenimage, "200x105+1160+560")
Bayview_thisyear6 <- image_crop(Bayview_screenimage, "200x105+1160+672")
Bayview_thisyear7 <- image_crop(Bayview_screenimage, "200x105+1160+784")
Bayview_thisyear8 <- image_crop(Bayview_screenimage, "200x105+1160+896")
Bayview_thisyear9 <- image_crop(Bayview_screenimage, "200x105+1160+1008")
Bayview_thisyear10 <- image_crop(Bayview_screenimage, "200x105+1160+1120")
Bayview_thisyear11 <- image_crop(Bayview_screenimage, "200x105+1160+1232")
Bayview_thisyear12 <- image_crop(Bayview_screenimage, "200x105+1160+1344")
Central_title1 <- image_crop(Central_screenimage, "200x105+940+112")
Central_title2 <- image_crop(Central_screenimage, "200x105+940+224")
Central_title3 <- image_crop(Central_screenimage, "200x105+940+336")
Central_title4 <- image_crop(Central_screenimage, "200x105+940+448")
Central_title5 <- image_crop(Central_screenimage, "200x105+940+560")
Central_title6 <- image_crop(Central_screenimage, "200x105+940+672")
Central_title7 <- image_crop(Central_screenimage, "200x105+940+784")
Central_title8 <- image_crop(Central_screenimage, "200x105+940+896")
Central_title9 <- image_crop(Central_screenimage, "200x105+940+1008")
Central_title10 <- image_crop(Central_screenimage, "200x105+940+1120")
Central_title11 <- image_crop(Central_screenimage, "200x105+940+1232")
Central_title12 <- image_crop(Central_screenimage, "200x105+940+1344")
Central_thisyear1 <- image_crop(Central_screenimage, "200x105+1160+112")
Central_thisyear2 <- image_crop(Central_screenimage, "200x105+1160+224")
Central_thisyear3 <- image_crop(Central_screenimage, "200x105+1160+336")
Central_thisyear4 <- image_crop(Central_screenimage, "200x105+1160+448")
Central_thisyear5 <- image_crop(Central_screenimage, "200x105+1160+560")
Central_thisyear6 <- image_crop(Central_screenimage, "200x105+1160+672")
Central_thisyear7 <- image_crop(Central_screenimage, "200x105+1160+784")
Central_thisyear8 <- image_crop(Central_screenimage, "200x105+1160+896")
Central_thisyear9 <- image_crop(Central_screenimage, "200x105+1160+1008")
Central_thisyear10 <- image_crop(Central_screenimage, "200x105+1160+1120")
Central_thisyear11 <- image_crop(Central_screenimage, "200x105+1160+1232")
Central_thisyear12 <- image_crop(Central_screenimage, "200x105+1160+1344")
Ingleside_title1 <- image_crop(Ingleside_screenimage, "200x105+940+112")
Ingleside_title2 <- image_crop(Ingleside_screenimage, "200x105+940+224")
Ingleside_title3 <- image_crop(Ingleside_screenimage, "200x105+940+336")
Ingleside_title4 <- image_crop(Ingleside_screenimage, "200x105+940+448")
Ingleside_title5 <- image_crop(Ingleside_screenimage, "200x105+940+560")
Ingleside_title6 <- image_crop(Ingleside_screenimage, "200x105+940+672")
Ingleside_title7 <- image_crop(Ingleside_screenimage, "200x105+940+784")
Ingleside_title8 <- image_crop(Ingleside_screenimage, "200x105+940+896")
Ingleside_title9 <- image_crop(Ingleside_screenimage, "200x105+940+1008")
Ingleside_title10 <- image_crop(Ingleside_screenimage, "200x105+940+1120")
Ingleside_title11 <- image_crop(Ingleside_screenimage, "200x105+940+1232")
Ingleside_title12 <- image_crop(Ingleside_screenimage, "200x105+940+1344")
Ingleside_thisyear1 <- image_crop(Ingleside_screenimage, "200x105+1160+112")
Ingleside_thisyear2 <- image_crop(Ingleside_screenimage, "200x105+1160+224")
Ingleside_thisyear3 <- image_crop(Ingleside_screenimage, "200x105+1160+336")
Ingleside_thisyear4 <- image_crop(Ingleside_screenimage, "200x105+1160+448")
Ingleside_thisyear5 <- image_crop(Ingleside_screenimage, "200x105+1160+560")
Ingleside_thisyear6 <- image_crop(Ingleside_screenimage, "200x105+1160+672")
Ingleside_thisyear7 <- image_crop(Ingleside_screenimage, "200x105+1160+784")
Ingleside_thisyear8 <- image_crop(Ingleside_screenimage, "200x105+1160+896")
Ingleside_thisyear9 <- image_crop(Ingleside_screenimage, "200x105+1160+1008")
Ingleside_thisyear10 <- image_crop(Ingleside_screenimage, "200x105+1160+1120")
Ingleside_thisyear11 <- image_crop(Ingleside_screenimage, "200x105+1160+1232")
Ingleside_thisyear12 <- image_crop(Ingleside_screenimage, "200x105+1160+1344")
Mission_title1 <- image_crop(Mission_screenimage, "200x105+940+112")
Mission_title2 <- image_crop(Mission_screenimage, "200x105+940+224")
Mission_title3 <- image_crop(Mission_screenimage, "200x105+940+336")
Mission_title4 <- image_crop(Mission_screenimage, "200x105+940+448")
Mission_title5 <- image_crop(Mission_screenimage, "200x105+940+560")
Mission_title6 <- image_crop(Mission_screenimage, "200x105+940+672")
Mission_title7 <- image_crop(Mission_screenimage, "200x105+940+784")
Mission_title8 <- image_crop(Mission_screenimage, "200x105+940+896")
Mission_title9 <- image_crop(Mission_screenimage, "200x105+940+1008")
Mission_title10 <- image_crop(Mission_screenimage, "200x105+940+1120")
Mission_title11 <- image_crop(Mission_screenimage, "200x105+940+1232")
Mission_title12 <- image_crop(Mission_screenimage, "200x105+940+1344")
Mission_thisyear1 <- image_crop(Mission_screenimage, "200x105+1160+112")
Mission_thisyear2 <- image_crop(Mission_screenimage, "200x105+1160+224")
Mission_thisyear3 <- image_crop(Mission_screenimage, "200x105+1160+336")
Mission_thisyear4 <- image_crop(Mission_screenimage, "200x105+1160+448")
Mission_thisyear5 <- image_crop(Mission_screenimage, "200x105+1160+560")
Mission_thisyear6 <- image_crop(Mission_screenimage, "200x105+1160+672")
Mission_thisyear7 <- image_crop(Mission_screenimage, "200x105+1160+784")
Mission_thisyear8 <- image_crop(Mission_screenimage, "200x105+1160+896")
Mission_thisyear9 <- image_crop(Mission_screenimage, "200x105+1160+1008")
Mission_thisyear10 <- image_crop(Mission_screenimage, "200x105+1160+1120")
Mission_thisyear11 <- image_crop(Mission_screenimage, "200x105+1160+1232")
Mission_thisyear12 <- image_crop(Mission_screenimage, "200x105+1160+1344")
Northern_title1 <- image_crop(Northern_screenimage, "200x105+940+112")
Northern_title2 <- image_crop(Northern_screenimage, "200x105+940+224")
Northern_title3 <- image_crop(Northern_screenimage, "200x105+940+336")
Northern_title4 <- image_crop(Northern_screenimage, "200x105+940+448")
Northern_title5 <- image_crop(Northern_screenimage, "200x105+940+560")
Northern_title6 <- image_crop(Northern_screenimage, "200x105+940+672")
Northern_title7 <- image_crop(Northern_screenimage, "200x105+940+784")
Northern_title8 <- image_crop(Northern_screenimage, "200x105+940+896")
Northern_title9 <- image_crop(Northern_screenimage, "200x105+940+1008")
Northern_title10 <- image_crop(Northern_screenimage, "200x105+940+1120")
Northern_title11 <- image_crop(Northern_screenimage, "200x105+940+1232")
Northern_title12 <- image_crop(Northern_screenimage, "200x105+940+1344")
Northern_thisyear1 <- image_crop(Northern_screenimage, "200x105+1160+112")
Northern_thisyear2 <- image_crop(Northern_screenimage, "200x105+1160+224")
Northern_thisyear3 <- image_crop(Northern_screenimage, "200x105+1160+336")
Northern_thisyear4 <- image_crop(Northern_screenimage, "200x105+1160+448")
Northern_thisyear5 <- image_crop(Northern_screenimage, "200x105+1160+560")
Northern_thisyear6 <- image_crop(Northern_screenimage, "200x105+1160+672")
Northern_thisyear7 <- image_crop(Northern_screenimage, "200x105+1160+784")
Northern_thisyear8 <- image_crop(Northern_screenimage, "200x105+1160+896")
Northern_thisyear9 <- image_crop(Northern_screenimage, "200x105+1160+1008")
Northern_thisyear10 <- image_crop(Northern_screenimage, "200x105+1160+1120")
Northern_thisyear11 <- image_crop(Northern_screenimage, "200x105+1160+1232")
Northern_thisyear12 <- image_crop(Northern_screenimage, "200x105+1160+1344")
Park_title1 <- image_crop(Park_screenimage, "200x105+940+112")
Park_title2 <- image_crop(Park_screenimage, "200x105+940+224")
Park_title3 <- image_crop(Park_screenimage, "200x105+940+336")
Park_title4 <- image_crop(Park_screenimage, "200x105+940+448")
Park_title5 <- image_crop(Park_screenimage, "200x105+940+560")
Park_title6 <- image_crop(Park_screenimage, "200x105+940+672")
Park_title7 <- image_crop(Park_screenimage, "200x105+940+784")
Park_title8 <- image_crop(Park_screenimage, "200x105+940+896")
Park_title9 <- image_crop(Park_screenimage, "200x105+940+1008")
Park_title10 <- image_crop(Park_screenimage, "200x105+940+1120")
Park_title11 <- image_crop(Park_screenimage, "200x105+940+1232")
Park_title12 <- image_crop(Park_screenimage, "200x105+940+1344")
Park_thisyear1 <- image_crop(Park_screenimage, "200x105+1160+112")
Park_thisyear2 <- image_crop(Park_screenimage, "200x105+1160+224")
Park_thisyear3 <- image_crop(Park_screenimage, "200x105+1160+336")
Park_thisyear4 <- image_crop(Park_screenimage, "200x105+1160+448")
Park_thisyear5 <- image_crop(Park_screenimage, "200x105+1160+560")
Park_thisyear6 <- image_crop(Park_screenimage, "200x105+1160+672")
Park_thisyear7 <- image_crop(Park_screenimage, "200x105+1160+784")
Park_thisyear8 <- image_crop(Park_screenimage, "200x105+1160+896")
Park_thisyear9 <- image_crop(Park_screenimage, "200x105+1160+1008")
Park_thisyear10 <- image_crop(Park_screenimage, "200x105+1160+1120")
Park_thisyear11 <- image_crop(Park_screenimage, "200x105+1160+1232")
Park_thisyear12 <- image_crop(Park_screenimage, "200x105+1160+1344")
Richmond_title1 <- image_crop(Richmond_screenimage, "200x105+940+112")
Richmond_title2 <- image_crop(Richmond_screenimage, "200x105+940+224")
Richmond_title3 <- image_crop(Richmond_screenimage, "200x105+940+336")
Richmond_title4 <- image_crop(Richmond_screenimage, "200x105+940+448")
Richmond_title5 <- image_crop(Richmond_screenimage, "200x105+940+560")
Richmond_title6 <- image_crop(Richmond_screenimage, "200x105+940+672")
Richmond_title7 <- image_crop(Richmond_screenimage, "200x105+940+784")
Richmond_title8 <- image_crop(Richmond_screenimage, "200x105+940+896")
Richmond_title9 <- image_crop(Richmond_screenimage, "200x105+940+1008")
Richmond_title10 <- image_crop(Richmond_screenimage, "200x105+940+1120")
Richmond_title11 <- image_crop(Richmond_screenimage, "200x105+940+1232")
Richmond_title12 <- image_crop(Richmond_screenimage, "200x105+940+1344")
Richmond_thisyear1 <- image_crop(Richmond_screenimage, "200x105+1160+112")
Richmond_thisyear2 <- image_crop(Richmond_screenimage, "200x105+1160+224")
Richmond_thisyear3 <- image_crop(Richmond_screenimage, "200x105+1160+336")
Richmond_thisyear4 <- image_crop(Richmond_screenimage, "200x105+1160+448")
Richmond_thisyear5 <- image_crop(Richmond_screenimage, "200x105+1160+560")
Richmond_thisyear6 <- image_crop(Richmond_screenimage, "200x105+1160+672")
Richmond_thisyear7 <- image_crop(Richmond_screenimage, "200x105+1160+784")
Richmond_thisyear8 <- image_crop(Richmond_screenimage, "200x105+1160+896")
Richmond_thisyear9 <- image_crop(Richmond_screenimage, "200x105+1160+1008")
Richmond_thisyear10 <- image_crop(Richmond_screenimage, "200x105+1160+1120")
Richmond_thisyear11 <- image_crop(Richmond_screenimage, "200x105+1160+1232")
Richmond_thisyear12 <- image_crop(Richmond_screenimage, "200x105+1160+1344")
Southern_title1 <- image_crop(Southern_screenimage, "200x105+940+112")
Southern_title2 <- image_crop(Southern_screenimage, "200x105+940+224")
Southern_title3 <- image_crop(Southern_screenimage, "200x105+940+336")
Southern_title4 <- image_crop(Southern_screenimage, "200x105+940+448")
Southern_title5 <- image_crop(Southern_screenimage, "200x105+940+560")
Southern_title6 <- image_crop(Southern_screenimage, "200x105+940+672")
Southern_title7 <- image_crop(Southern_screenimage, "200x105+940+784")
Southern_title8 <- image_crop(Southern_screenimage, "200x105+940+896")
Southern_title9 <- image_crop(Southern_screenimage, "200x105+940+1008")
Southern_title10 <- image_crop(Southern_screenimage, "200x105+940+1120")
Southern_title11 <- image_crop(Southern_screenimage, "200x105+940+1232")
Southern_title12 <- image_crop(Southern_screenimage, "200x105+940+1344")
Southern_thisyear1 <- image_crop(Southern_screenimage, "200x105+1160+112")
Southern_thisyear2 <- image_crop(Southern_screenimage, "200x105+1160+224")
Southern_thisyear3 <- image_crop(Southern_screenimage, "200x105+1160+336")
Southern_thisyear4 <- image_crop(Southern_screenimage, "200x105+1160+448")
Southern_thisyear5 <- image_crop(Southern_screenimage, "200x105+1160+560")
Southern_thisyear6 <- image_crop(Southern_screenimage, "200x105+1160+672")
Southern_thisyear7 <- image_crop(Southern_screenimage, "200x105+1160+784")
Southern_thisyear8 <- image_crop(Southern_screenimage, "200x105+1160+896")
Southern_thisyear9 <- image_crop(Southern_screenimage, "200x105+1160+1008")
Southern_thisyear10 <- image_crop(Southern_screenimage, "200x105+1160+1120")
Southern_thisyear11 <- image_crop(Southern_screenimage, "200x105+1160+1232")
Southern_thisyear12 <- image_crop(Southern_screenimage, "200x105+1160+1344")
Taraval_title1 <- image_crop(Taraval_screenimage, "200x105+940+112")
Taraval_title2 <- image_crop(Taraval_screenimage, "200x105+940+224")
Taraval_title3 <- image_crop(Taraval_screenimage, "200x105+940+336")
Taraval_title4 <- image_crop(Taraval_screenimage, "200x105+940+448")
Taraval_title5 <- image_crop(Taraval_screenimage, "200x105+940+560")
Taraval_title6 <- image_crop(Taraval_screenimage, "200x105+940+672")
Taraval_title7 <- image_crop(Taraval_screenimage, "200x105+940+784")
Taraval_title8 <- image_crop(Taraval_screenimage, "200x105+940+896")
Taraval_title9 <- image_crop(Taraval_screenimage, "200x105+940+1008")
Taraval_title10 <- image_crop(Taraval_screenimage, "200x105+940+1120")
Taraval_title11 <- image_crop(Taraval_screenimage, "200x105+940+1232")
Taraval_title12 <- image_crop(Taraval_screenimage, "200x105+940+1344")
Taraval_thisyear1 <- image_crop(Taraval_screenimage, "200x105+1160+112")
Taraval_thisyear2 <- image_crop(Taraval_screenimage, "200x105+1160+224")
Taraval_thisyear3 <- image_crop(Taraval_screenimage, "200x105+1160+336")
Taraval_thisyear4 <- image_crop(Taraval_screenimage, "200x105+1160+448")
Taraval_thisyear5 <- image_crop(Taraval_screenimage, "200x105+1160+560")
Taraval_thisyear6 <- image_crop(Taraval_screenimage, "200x105+1160+672")
Taraval_thisyear7 <- image_crop(Taraval_screenimage, "200x105+1160+784")
Taraval_thisyear8 <- image_crop(Taraval_screenimage, "200x105+1160+896")
Taraval_thisyear9 <- image_crop(Taraval_screenimage, "200x105+1160+1008")
Taraval_thisyear10 <- image_crop(Taraval_screenimage, "200x105+1160+1120")
Taraval_thisyear11 <- image_crop(Taraval_screenimage, "200x105+1160+1232")
Taraval_thisyear12 <- image_crop(Taraval_screenimage, "200x105+1160+1344")
Tenderloin_title1 <- image_crop(Tenderloin_screenimage, "200x105+940+112")
Tenderloin_title2 <- image_crop(Tenderloin_screenimage, "200x105+940+224")
Tenderloin_title3 <- image_crop(Tenderloin_screenimage, "200x105+940+336")
Tenderloin_title4 <- image_crop(Tenderloin_screenimage, "200x105+940+448")
Tenderloin_title5 <- image_crop(Tenderloin_screenimage, "200x105+940+560")
Tenderloin_title6 <- image_crop(Tenderloin_screenimage, "200x105+940+672")
Tenderloin_title7 <- image_crop(Tenderloin_screenimage, "200x105+940+784")
Tenderloin_title8 <- image_crop(Tenderloin_screenimage, "200x105+940+896")
Tenderloin_title9 <- image_crop(Tenderloin_screenimage, "200x105+940+1008")
Tenderloin_title10 <- image_crop(Tenderloin_screenimage, "200x105+940+1120")
Tenderloin_title11 <- image_crop(Tenderloin_screenimage, "200x105+940+1232")
Tenderloin_title12 <- image_crop(Tenderloin_screenimage, "200x105+940+1344")
Tenderloin_thisyear1 <- image_crop(Tenderloin_screenimage, "200x105+1160+112")
Tenderloin_thisyear2 <- image_crop(Tenderloin_screenimage, "200x105+1160+224")
Tenderloin_thisyear3 <- image_crop(Tenderloin_screenimage, "200x105+1160+336")
Tenderloin_thisyear4 <- image_crop(Tenderloin_screenimage, "200x105+1160+448")
Tenderloin_thisyear5 <- image_crop(Tenderloin_screenimage, "200x105+1160+560")
Tenderloin_thisyear6 <- image_crop(Tenderloin_screenimage, "200x105+1160+672")
Tenderloin_thisyear7 <- image_crop(Tenderloin_screenimage, "200x105+1160+784")
Tenderloin_thisyear8 <- image_crop(Tenderloin_screenimage, "200x105+1160+896")
Tenderloin_thisyear9 <- image_crop(Tenderloin_screenimage, "200x105+1160+1008")
Tenderloin_thisyear10 <- image_crop(Tenderloin_screenimage, "200x105+1160+1120")
Tenderloin_thisyear11 <- image_crop(Tenderloin_screenimage, "200x105+1160+1232")
Tenderloin_thisyear12 <- image_crop(Tenderloin_screenimage, "200x105+1160+1344")

# Now we're going to save each cell as a png for ocr purposes
image_write(SF_update, path = "data/source/images/SF_update.png", format = "png")
image_write(SF_title1, path = "data/source/images/SF_title1.png", format = "png")
image_write(SF_title2, path = "data/source/images/SF_title2.png", format = "png")
image_write(SF_title3, path = "data/source/images/SF_title3.png", format = "png")
image_write(SF_title4, path = "data/source/images/SF_title4.png", format = "png")
image_write(SF_title5, path = "data/source/images/SF_title5.png", format = "png")
image_write(SF_title6, path = "data/source/images/SF_title6.png", format = "png")
image_write(SF_title7, path = "data/source/images/SF_title7.png", format = "png")
image_write(SF_title8, path = "data/source/images/SF_title8.png", format = "png")
image_write(SF_title9, path = "data/source/images/SF_title9.png", format = "png")
image_write(SF_title10, path = "data/source/images/SF_title10.png", format = "png")
image_write(SF_title11, path = "data/source/images/SF_title11.png", format = "png")
image_write(SF_title12, path = "data/source/images/SF_title12.png", format = "png")
image_write(SF_thisyear1, path = "data/source/images/SF_thisyear1.png", format = "png")
image_write(SF_thisyear2, path = "data/source/images/SF_thisyear2.png", format = "png")
image_write(SF_thisyear3, path = "data/source/images/SF_thisyear3.png", format = "png")
image_write(SF_thisyear4, path = "data/source/images/SF_thisyear4.png", format = "png")
image_write(SF_thisyear5, path = "data/source/images/SF_thisyear5.png", format = "png")
image_write(SF_thisyear6, path = "data/source/images/SF_thisyear6.png", format = "png")
image_write(SF_thisyear7, path = "data/source/images/SF_thisyear7.png", format = "png")
image_write(SF_thisyear8, path = "data/source/images/SF_thisyear8.png", format = "png")
image_write(SF_thisyear9, path = "data/source/images/SF_thisyear9.png", format = "png")
image_write(SF_thisyear10, path = "data/source/images/SF_thisyear10.png", format = "png")
image_write(SF_thisyear11, path = "data/source/images/SF_thisyear11.png", format = "png")
image_write(SF_thisyear12, path = "data/source/images/SF_thisyear12.png", format = "png")
image_write(Bayview_title1, path = "data/source/images/Bayview_title1.png", format = "png")
image_write(Bayview_title2, path = "data/source/images/Bayview_title2.png", format = "png")
image_write(Bayview_title3, path = "data/source/images/Bayview_title3.png", format = "png")
image_write(Bayview_title4, path = "data/source/images/Bayview_title4.png", format = "png")
image_write(Bayview_title5, path = "data/source/images/Bayview_title5.png", format = "png")
image_write(Bayview_title6, path = "data/source/images/Bayview_title6.png", format = "png")
image_write(Bayview_title7, path = "data/source/images/Bayview_title7.png", format = "png")
image_write(Bayview_title8, path = "data/source/images/Bayview_title8.png", format = "png")
image_write(Bayview_title9, path = "data/source/images/Bayview_title9.png", format = "png")
image_write(Bayview_title10, path = "data/source/images/Bayview_title10.png", format = "png")
image_write(Bayview_title11, path = "data/source/images/Bayview_title11.png", format = "png")
image_write(Bayview_title12, path = "data/source/images/Bayview_title12.png", format = "png")
image_write(Bayview_thisyear1, path = "data/source/images/Bayview_thisyear1.png", format = "png")
image_write(Bayview_thisyear2, path = "data/source/images/Bayview_thisyear2.png", format = "png")
image_write(Bayview_thisyear3, path = "data/source/images/Bayview_thisyear3.png", format = "png")
image_write(Bayview_thisyear4, path = "data/source/images/Bayview_thisyear4.png", format = "png")
image_write(Bayview_thisyear5, path = "data/source/images/Bayview_thisyear5.png", format = "png")
image_write(Bayview_thisyear6, path = "data/source/images/Bayview_thisyear6.png", format = "png")
image_write(Bayview_thisyear7, path = "data/source/images/Bayview_thisyear7.png", format = "png")
image_write(Bayview_thisyear8, path = "data/source/images/Bayview_thisyear8.png", format = "png")
image_write(Bayview_thisyear9, path = "data/source/images/Bayview_thisyear9.png", format = "png")
image_write(Bayview_thisyear10, path = "data/source/images/Bayview_thisyear10.png", format = "png")
image_write(Bayview_thisyear11, path = "data/source/images/Bayview_thisyear11.png", format = "png")
image_write(Bayview_thisyear12, path = "data/source/images/Bayview_thisyear12.png", format = "png")
image_write(Central_title1, path = "data/source/images/Central_title1.png", format = "png")
image_write(Central_title2, path = "data/source/images/Central_title2.png", format = "png")
image_write(Central_title3, path = "data/source/images/Central_title3.png", format = "png")
image_write(Central_title4, path = "data/source/images/Central_title4.png", format = "png")
image_write(Central_title5, path = "data/source/images/Central_title5.png", format = "png")
image_write(Central_title6, path = "data/source/images/Central_title6.png", format = "png")
image_write(Central_title7, path = "data/source/images/Central_title7.png", format = "png")
image_write(Central_title8, path = "data/source/images/Central_title8.png", format = "png")
image_write(Central_title9, path = "data/source/images/Central_title9.png", format = "png")
image_write(Central_title10, path = "data/source/images/Central_title10.png", format = "png")
image_write(Central_title11, path = "data/source/images/Central_title11.png", format = "png")
image_write(Central_title12, path = "data/source/images/Central_title12.png", format = "png")
image_write(Central_thisyear1, path = "data/source/images/Central_thisyear1.png", format = "png")
image_write(Central_thisyear2, path = "data/source/images/Central_thisyear2.png", format = "png")
image_write(Central_thisyear3, path = "data/source/images/Central_thisyear3.png", format = "png")
image_write(Central_thisyear4, path = "data/source/images/Central_thisyear4.png", format = "png")
image_write(Central_thisyear5, path = "data/source/images/Central_thisyear5.png", format = "png")
image_write(Central_thisyear6, path = "data/source/images/Central_thisyear6.png", format = "png")
image_write(Central_thisyear7, path = "data/source/images/Central_thisyear7.png", format = "png")
image_write(Central_thisyear8, path = "data/source/images/Central_thisyear8.png", format = "png")
image_write(Central_thisyear9, path = "data/source/images/Central_thisyear9.png", format = "png")
image_write(Central_thisyear10, path = "data/source/images/Central_thisyear10.png", format = "png")
image_write(Central_thisyear11, path = "data/source/images/Central_thisyear11.png", format = "png")
image_write(Central_thisyear12, path = "data/source/images/Central_thisyear12.png", format = "png")
image_write(Ingleside_title1, path = "data/source/images/Ingleside_title1.png", format = "png")
image_write(Ingleside_title2, path = "data/source/images/Ingleside_title2.png", format = "png")
image_write(Ingleside_title3, path = "data/source/images/Ingleside_title3.png", format = "png")
image_write(Ingleside_title4, path = "data/source/images/Ingleside_title4.png", format = "png")
image_write(Ingleside_title5, path = "data/source/images/Ingleside_title5.png", format = "png")
image_write(Ingleside_title6, path = "data/source/images/Ingleside_title6.png", format = "png")
image_write(Ingleside_title7, path = "data/source/images/Ingleside_title7.png", format = "png")
image_write(Ingleside_title8, path = "data/source/images/Ingleside_title8.png", format = "png")
image_write(Ingleside_title9, path = "data/source/images/Ingleside_title9.png", format = "png")
image_write(Ingleside_title10, path = "data/source/images/Ingleside_title10.png", format = "png")
image_write(Ingleside_title11, path = "data/source/images/Ingleside_title11.png", format = "png")
image_write(Ingleside_title12, path = "data/source/images/Ingleside_title12.png", format = "png")
image_write(Ingleside_thisyear1, path = "data/source/images/Ingleside_thisyear1.png", format = "png")
image_write(Ingleside_thisyear2, path = "data/source/images/Ingleside_thisyear2.png", format = "png")
image_write(Ingleside_thisyear3, path = "data/source/images/Ingleside_thisyear3.png", format = "png")
image_write(Ingleside_thisyear4, path = "data/source/images/Ingleside_thisyear4.png", format = "png")
image_write(Ingleside_thisyear5, path = "data/source/images/Ingleside_thisyear5.png", format = "png")
image_write(Ingleside_thisyear6, path = "data/source/images/Ingleside_thisyear6.png", format = "png")
image_write(Ingleside_thisyear7, path = "data/source/images/Ingleside_thisyear7.png", format = "png")
image_write(Ingleside_thisyear8, path = "data/source/images/Ingleside_thisyear8.png", format = "png")
image_write(Ingleside_thisyear9, path = "data/source/images/Ingleside_thisyear9.png", format = "png")
image_write(Ingleside_thisyear10, path = "data/source/images/Ingleside_thisyear10.png", format = "png")
image_write(Ingleside_thisyear11, path = "data/source/images/Ingleside_thisyear11.png", format = "png")
image_write(Ingleside_thisyear12, path = "data/source/images/Ingleside_thisyear12.png", format = "png")
image_write(Mission_title1, path = "data/source/images/Mission_title1.png", format = "png")
image_write(Mission_title2, path = "data/source/images/Mission_title2.png", format = "png")
image_write(Mission_title3, path = "data/source/images/Mission_title3.png", format = "png")
image_write(Mission_title4, path = "data/source/images/Mission_title4.png", format = "png")
image_write(Mission_title5, path = "data/source/images/Mission_title5.png", format = "png")
image_write(Mission_title6, path = "data/source/images/Mission_title6.png", format = "png")
image_write(Mission_title7, path = "data/source/images/Mission_title7.png", format = "png")
image_write(Mission_title8, path = "data/source/images/Mission_title8.png", format = "png")
image_write(Mission_title9, path = "data/source/images/Mission_title9.png", format = "png")
image_write(Mission_title10, path = "data/source/images/Mission_title10.png", format = "png")
image_write(Mission_title11, path = "data/source/images/Mission_title11.png", format = "png")
image_write(Mission_title12, path = "data/source/images/Mission_title12.png", format = "png")
image_write(Mission_thisyear1, path = "data/source/images/Mission_thisyear1.png", format = "png")
image_write(Mission_thisyear2, path = "data/source/images/Mission_thisyear2.png", format = "png")
image_write(Mission_thisyear3, path = "data/source/images/Mission_thisyear3.png", format = "png")
image_write(Mission_thisyear4, path = "data/source/images/Mission_thisyear4.png", format = "png")
image_write(Mission_thisyear5, path = "data/source/images/Mission_thisyear5.png", format = "png")
image_write(Mission_thisyear6, path = "data/source/images/Mission_thisyear6.png", format = "png")
image_write(Mission_thisyear7, path = "data/source/images/Mission_thisyear7.png", format = "png")
image_write(Mission_thisyear8, path = "data/source/images/Mission_thisyear8.png", format = "png")
image_write(Mission_thisyear9, path = "data/source/images/Mission_thisyear9.png", format = "png")
image_write(Mission_thisyear10, path = "data/source/images/Mission_thisyear10.png", format = "png")
image_write(Mission_thisyear11, path = "data/source/images/Mission_thisyear11.png", format = "png")
image_write(Mission_thisyear12, path = "data/source/images/Mission_thisyear12.png", format = "png")
image_write(Northern_title1, path = "data/source/images/Northern_title1.png", format = "png")
image_write(Northern_title2, path = "data/source/images/Northern_title2.png", format = "png")
image_write(Northern_title3, path = "data/source/images/Northern_title3.png", format = "png")
image_write(Northern_title4, path = "data/source/images/Northern_title4.png", format = "png")
image_write(Northern_title5, path = "data/source/images/Northern_title5.png", format = "png")
image_write(Northern_title6, path = "data/source/images/Northern_title6.png", format = "png")
image_write(Northern_title7, path = "data/source/images/Northern_title7.png", format = "png")
image_write(Northern_title8, path = "data/source/images/Northern_title8.png", format = "png")
image_write(Northern_title9, path = "data/source/images/Northern_title9.png", format = "png")
image_write(Northern_title10, path = "data/source/images/Northern_title10.png", format = "png")
image_write(Northern_title11, path = "data/source/images/Northern_title11.png", format = "png")
image_write(Northern_title12, path = "data/source/images/Northern_title12.png", format = "png")
image_write(Northern_thisyear1, path = "data/source/images/Northern_thisyear1.png", format = "png")
image_write(Northern_thisyear2, path = "data/source/images/Northern_thisyear2.png", format = "png")
image_write(Northern_thisyear3, path = "data/source/images/Northern_thisyear3.png", format = "png")
image_write(Northern_thisyear4, path = "data/source/images/Northern_thisyear4.png", format = "png")
image_write(Northern_thisyear5, path = "data/source/images/Northern_thisyear5.png", format = "png")
image_write(Northern_thisyear6, path = "data/source/images/Northern_thisyear6.png", format = "png")
image_write(Northern_thisyear7, path = "data/source/images/Northern_thisyear7.png", format = "png")
image_write(Northern_thisyear8, path = "data/source/images/Northern_thisyear8.png", format = "png")
image_write(Northern_thisyear9, path = "data/source/images/Northern_thisyear9.png", format = "png")
image_write(Northern_thisyear10, path = "data/source/images/Northern_thisyear10.png", format = "png")
image_write(Northern_thisyear11, path = "data/source/images/Northern_thisyear11.png", format = "png")
image_write(Northern_thisyear12, path = "data/source/images/Northern_thisyear12.png", format = "png")
image_write(Park_title1, path = "data/source/images/Park_title1.png", format = "png")
image_write(Park_title2, path = "data/source/images/Park_title2.png", format = "png")
image_write(Park_title3, path = "data/source/images/Park_title3.png", format = "png")
image_write(Park_title4, path = "data/source/images/Park_title4.png", format = "png")
image_write(Park_title5, path = "data/source/images/Park_title5.png", format = "png")
image_write(Park_title6, path = "data/source/images/Park_title6.png", format = "png")
image_write(Park_title7, path = "data/source/images/Park_title7.png", format = "png")
image_write(Park_title8, path = "data/source/images/Park_title8.png", format = "png")
image_write(Park_title9, path = "data/source/images/Park_title9.png", format = "png")
image_write(Park_title10, path = "data/source/images/Park_title10.png", format = "png")
image_write(Park_title11, path = "data/source/images/Park_title11.png", format = "png")
image_write(Park_title12, path = "data/source/images/Park_title12.png", format = "png")
image_write(Park_thisyear1, path = "data/source/images/Park_thisyear1.png", format = "png")
image_write(Park_thisyear2, path = "data/source/images/Park_thisyear2.png", format = "png")
image_write(Park_thisyear3, path = "data/source/images/Park_thisyear3.png", format = "png")
image_write(Park_thisyear4, path = "data/source/images/Park_thisyear4.png", format = "png")
image_write(Park_thisyear5, path = "data/source/images/Park_thisyear5.png", format = "png")
image_write(Park_thisyear6, path = "data/source/images/Park_thisyear6.png", format = "png")
image_write(Park_thisyear7, path = "data/source/images/Park_thisyear7.png", format = "png")
image_write(Park_thisyear8, path = "data/source/images/Park_thisyear8.png", format = "png")
image_write(Park_thisyear9, path = "data/source/images/Park_thisyear9.png", format = "png")
image_write(Park_thisyear10, path = "data/source/images/Park_thisyear10.png", format = "png")
image_write(Park_thisyear11, path = "data/source/images/Park_thisyear11.png", format = "png")
image_write(Park_thisyear12, path = "data/source/images/Park_thisyear12.png", format = "png")
image_write(Richmond_title1, path = "data/source/images/Richmond_title1.png", format = "png")
image_write(Richmond_title2, path = "data/source/images/Richmond_title2.png", format = "png")
image_write(Richmond_title3, path = "data/source/images/Richmond_title3.png", format = "png")
image_write(Richmond_title4, path = "data/source/images/Richmond_title4.png", format = "png")
image_write(Richmond_title5, path = "data/source/images/Richmond_title5.png", format = "png")
image_write(Richmond_title6, path = "data/source/images/Richmond_title6.png", format = "png")
image_write(Richmond_title7, path = "data/source/images/Richmond_title7.png", format = "png")
image_write(Richmond_title8, path = "data/source/images/Richmond_title8.png", format = "png")
image_write(Richmond_title9, path = "data/source/images/Richmond_title9.png", format = "png")
image_write(Richmond_title10, path = "data/source/images/Richmond_title10.png", format = "png")
image_write(Richmond_title11, path = "data/source/images/Richmond_title11.png", format = "png")
image_write(Richmond_title12, path = "data/source/images/Richmond_title12.png", format = "png")
image_write(Richmond_thisyear1, path = "data/source/images/Richmond_thisyear1.png", format = "png")
image_write(Richmond_thisyear2, path = "data/source/images/Richmond_thisyear2.png", format = "png")
image_write(Richmond_thisyear3, path = "data/source/images/Richmond_thisyear3.png", format = "png")
image_write(Richmond_thisyear4, path = "data/source/images/Richmond_thisyear4.png", format = "png")
image_write(Richmond_thisyear5, path = "data/source/images/Richmond_thisyear5.png", format = "png")
image_write(Richmond_thisyear6, path = "data/source/images/Richmond_thisyear6.png", format = "png")
image_write(Richmond_thisyear7, path = "data/source/images/Richmond_thisyear7.png", format = "png")
image_write(Richmond_thisyear8, path = "data/source/images/Richmond_thisyear8.png", format = "png")
image_write(Richmond_thisyear9, path = "data/source/images/Richmond_thisyear9.png", format = "png")
image_write(Richmond_thisyear10, path = "data/source/images/Richmond_thisyear10.png", format = "png")
image_write(Richmond_thisyear11, path = "data/source/images/Richmond_thisyear11.png", format = "png")
image_write(Richmond_thisyear12, path = "data/source/images/Richmond_thisyear12.png", format = "png")
image_write(Southern_title1, path = "data/source/images/Southern_title1.png", format = "png")
image_write(Southern_title2, path = "data/source/images/Southern_title2.png", format = "png")
image_write(Southern_title3, path = "data/source/images/Southern_title3.png", format = "png")
image_write(Southern_title4, path = "data/source/images/Southern_title4.png", format = "png")
image_write(Southern_title5, path = "data/source/images/Southern_title5.png", format = "png")
image_write(Southern_title6, path = "data/source/images/Southern_title6.png", format = "png")
image_write(Southern_title7, path = "data/source/images/Southern_title7.png", format = "png")
image_write(Southern_title8, path = "data/source/images/Southern_title8.png", format = "png")
image_write(Southern_title9, path = "data/source/images/Southern_title9.png", format = "png")
image_write(Southern_title10, path = "data/source/images/Southern_title10.png", format = "png")
image_write(Southern_title11, path = "data/source/images/Southern_title11.png", format = "png")
image_write(Southern_title12, path = "data/source/images/Southern_title12.png", format = "png")
image_write(Southern_thisyear1, path = "data/source/images/Southern_thisyear1.png", format = "png")
image_write(Southern_thisyear2, path = "data/source/images/Southern_thisyear2.png", format = "png")
image_write(Southern_thisyear3, path = "data/source/images/Southern_thisyear3.png", format = "png")
image_write(Southern_thisyear4, path = "data/source/images/Southern_thisyear4.png", format = "png")
image_write(Southern_thisyear5, path = "data/source/images/Southern_thisyear5.png", format = "png")
image_write(Southern_thisyear6, path = "data/source/images/Southern_thisyear6.png", format = "png")
image_write(Southern_thisyear7, path = "data/source/images/Southern_thisyear7.png", format = "png")
image_write(Southern_thisyear8, path = "data/source/images/Southern_thisyear8.png", format = "png")
image_write(Southern_thisyear9, path = "data/source/images/Southern_thisyear9.png", format = "png")
image_write(Southern_thisyear10, path = "data/source/images/Southern_thisyear10.png", format = "png")
image_write(Southern_thisyear11, path = "data/source/images/Southern_thisyear11.png", format = "png")
image_write(Southern_thisyear12, path = "data/source/images/Southern_thisyear12.png", format = "png")
image_write(Taraval_title1, path = "data/source/images/Taraval_title1.png", format = "png")
image_write(Taraval_title2, path = "data/source/images/Taraval_title2.png", format = "png")
image_write(Taraval_title3, path = "data/source/images/Taraval_title3.png", format = "png")
image_write(Taraval_title4, path = "data/source/images/Taraval_title4.png", format = "png")
image_write(Taraval_title5, path = "data/source/images/Taraval_title5.png", format = "png")
image_write(Taraval_title6, path = "data/source/images/Taraval_title6.png", format = "png")
image_write(Taraval_title7, path = "data/source/images/Taraval_title7.png", format = "png")
image_write(Taraval_title8, path = "data/source/images/Taraval_title8.png", format = "png")
image_write(Taraval_title9, path = "data/source/images/Taraval_title9.png", format = "png")
image_write(Taraval_title10, path = "data/source/images/Taraval_title10.png", format = "png")
image_write(Taraval_title11, path = "data/source/images/Taraval_title11.png", format = "png")
image_write(Taraval_title12, path = "data/source/images/Taraval_title12.png", format = "png")
image_write(Taraval_thisyear1, path = "data/source/images/Taraval_thisyear1.png", format = "png")
image_write(Taraval_thisyear2, path = "data/source/images/Taraval_thisyear2.png", format = "png")
image_write(Taraval_thisyear3, path = "data/source/images/Taraval_thisyear3.png", format = "png")
image_write(Taraval_thisyear4, path = "data/source/images/Taraval_thisyear4.png", format = "png")
image_write(Taraval_thisyear5, path = "data/source/images/Taraval_thisyear5.png", format = "png")
image_write(Taraval_thisyear6, path = "data/source/images/Taraval_thisyear6.png", format = "png")
image_write(Taraval_thisyear7, path = "data/source/images/Taraval_thisyear7.png", format = "png")
image_write(Taraval_thisyear8, path = "data/source/images/Taraval_thisyear8.png", format = "png")
image_write(Taraval_thisyear9, path = "data/source/images/Taraval_thisyear9.png", format = "png")
image_write(Taraval_thisyear10, path = "data/source/images/Taraval_thisyear10.png", format = "png")
image_write(Taraval_thisyear11, path = "data/source/images/Taraval_thisyear11.png", format = "png")
image_write(Taraval_thisyear12, path = "data/source/images/Taraval_thisyear12.png", format = "png")
image_write(Tenderloin_title1, path = "data/source/images/Tenderloin_title1.png", format = "png")
image_write(Tenderloin_title2, path = "data/source/images/Tenderloin_title2.png", format = "png")
image_write(Tenderloin_title3, path = "data/source/images/Tenderloin_title3.png", format = "png")
image_write(Tenderloin_title4, path = "data/source/images/Tenderloin_title4.png", format = "png")
image_write(Tenderloin_title5, path = "data/source/images/Tenderloin_title5.png", format = "png")
image_write(Tenderloin_title6, path = "data/source/images/Tenderloin_title6.png", format = "png")
image_write(Tenderloin_title7, path = "data/source/images/Tenderloin_title7.png", format = "png")
image_write(Tenderloin_title8, path = "data/source/images/Tenderloin_title8.png", format = "png")
image_write(Tenderloin_title9, path = "data/source/images/Tenderloin_title9.png", format = "png")
image_write(Tenderloin_title10, path = "data/source/images/Tenderloin_title10.png", format = "png")
image_write(Tenderloin_title11, path = "data/source/images/Tenderloin_title11.png", format = "png")
image_write(Tenderloin_title12, path = "data/source/images/Tenderloin_title12.png", format = "png")
image_write(Tenderloin_thisyear1, path = "data/source/images/Tenderloin_thisyear1.png", format = "png")
image_write(Tenderloin_thisyear2, path = "data/source/images/Tenderloin_thisyear2.png", format = "png")
image_write(Tenderloin_thisyear3, path = "data/source/images/Tenderloin_thisyear3.png", format = "png")
image_write(Tenderloin_thisyear4, path = "data/source/images/Tenderloin_thisyear4.png", format = "png")
image_write(Tenderloin_thisyear5, path = "data/source/images/Tenderloin_thisyear5.png", format = "png")
image_write(Tenderloin_thisyear6, path = "data/source/images/Tenderloin_thisyear6.png", format = "png")
image_write(Tenderloin_thisyear7, path = "data/source/images/Tenderloin_thisyear7.png", format = "png")
image_write(Tenderloin_thisyear8, path = "data/source/images/Tenderloin_thisyear8.png", format = "png")
image_write(Tenderloin_thisyear9, path = "data/source/images/Tenderloin_thisyear9.png", format = "png")
image_write(Tenderloin_thisyear10, path = "data/source/images/Tenderloin_thisyear10.png", format = "png")
image_write(Tenderloin_thisyear11, path = "data/source/images/Tenderloin_thisyear11.png", format = "png")
image_write(Tenderloin_thisyear12, path = "data/source/images/Tenderloin_thisyear12.png", format = "png")

# Read the text from within the images of each cell
# Start with setting the encoding
eng <- tesseract("eng")
# read each image via ocr
SFtable_update <- tesseract::ocr("data/source/images/SF_update.png", engine = eng)
SFtable_title1 <- tesseract::ocr("data/source/images/SF_title1.png", engine = eng)
SFtable_title2 <- tesseract::ocr("data/source/images/SF_title2.png", engine = eng)
SFtable_title3 <- tesseract::ocr("data/source/images/SF_title3.png", engine = eng)
SFtable_title4 <- tesseract::ocr("data/source/images/SF_title4.png", engine = eng)
SFtable_title5 <- tesseract::ocr("data/source/images/SF_title5.png", engine = eng)
SFtable_title6 <- tesseract::ocr("data/source/images/SF_title6.png", engine = eng)
SFtable_title7 <- tesseract::ocr("data/source/images/SF_title7.png", engine = eng)
SFtable_title8 <- tesseract::ocr("data/source/images/SF_title8.png", engine = eng)
SFtable_title9 <- tesseract::ocr("data/source/images/SF_title9.png", engine = eng)
SFtable_title10 <- tesseract::ocr("data/source/images/SF_title10.png", engine = eng)
SFtable_title11 <- tesseract::ocr("data/source/images/SF_title11.png", engine = eng)
SFtable_title12 <- tesseract::ocr("data/source/images/SF_title12.png", engine = eng)
SFtable_thisyear1 <- tesseract::ocr("data/source/images/SF_thisyear1.png", engine = eng)
SFtable_thisyear2 <- tesseract::ocr("data/source/images/SF_thisyear2.png", engine = eng)
SFtable_thisyear3 <- tesseract::ocr("data/source/images/SF_thisyear3.png", engine = eng)
SFtable_thisyear4 <- tesseract::ocr("data/source/images/SF_thisyear4.png", engine = eng)
SFtable_thisyear5 <- tesseract::ocr("data/source/images/SF_thisyear5.png", engine = eng)
SFtable_thisyear6 <- tesseract::ocr("data/source/images/SF_thisyear6.png", engine = eng)
SFtable_thisyear7 <- tesseract::ocr("data/source/images/SF_thisyear7.png", engine = eng)
SFtable_thisyear8 <- tesseract::ocr("data/source/images/SF_thisyear8.png", engine = eng)
SFtable_thisyear9 <- tesseract::ocr("data/source/images/SF_thisyear9.png", engine = eng)
SFtable_thisyear10 <- tesseract::ocr("data/source/images/SF_thisyear10.png", engine = eng)
SFtable_thisyear11 <- tesseract::ocr("data/source/images/SF_thisyear11.png", engine = eng)
SFtable_thisyear12 <- tesseract::ocr("data/source/images/SF_thisyear12.png", engine = eng)
Bayviewtable_title1 <- tesseract::ocr("data/source/images/Bayview_title1.png", engine = eng)
Bayviewtable_title2 <- tesseract::ocr("data/source/images/Bayview_title2.png", engine = eng)
Bayviewtable_title3 <- tesseract::ocr("data/source/images/Bayview_title3.png", engine = eng)
Bayviewtable_title4 <- tesseract::ocr("data/source/images/Bayview_title4.png", engine = eng)
Bayviewtable_title5 <- tesseract::ocr("data/source/images/Bayview_title5.png", engine = eng)
Bayviewtable_title6 <- tesseract::ocr("data/source/images/Bayview_title6.png", engine = eng)
Bayviewtable_title7 <- tesseract::ocr("data/source/images/Bayview_title7.png", engine = eng)
Bayviewtable_title8 <- tesseract::ocr("data/source/images/Bayview_title8.png", engine = eng)
Bayviewtable_title9 <- tesseract::ocr("data/source/images/Bayview_title9.png", engine = eng)
Bayviewtable_title10 <- tesseract::ocr("data/source/images/Bayview_title10.png", engine = eng)
Bayviewtable_title11 <- tesseract::ocr("data/source/images/Bayview_title11.png", engine = eng)
Bayviewtable_title12 <- tesseract::ocr("data/source/images/Bayview_title12.png", engine = eng)
Bayviewtable_thisyear1 <- tesseract::ocr("data/source/images/Bayview_thisyear1.png", engine = eng)
Bayviewtable_thisyear2 <- tesseract::ocr("data/source/images/Bayview_thisyear2.png", engine = eng)
Bayviewtable_thisyear3 <- tesseract::ocr("data/source/images/Bayview_thisyear3.png", engine = eng)
Bayviewtable_thisyear4 <- tesseract::ocr("data/source/images/Bayview_thisyear4.png", engine = eng)
Bayviewtable_thisyear5 <- tesseract::ocr("data/source/images/Bayview_thisyear5.png", engine = eng)
Bayviewtable_thisyear6 <- tesseract::ocr("data/source/images/Bayview_thisyear6.png", engine = eng)
Bayviewtable_thisyear7 <- tesseract::ocr("data/source/images/Bayview_thisyear7.png", engine = eng)
Bayviewtable_thisyear8 <- tesseract::ocr("data/source/images/Bayview_thisyear8.png", engine = eng)
Bayviewtable_thisyear9 <- tesseract::ocr("data/source/images/Bayview_thisyear9.png", engine = eng)
Bayviewtable_thisyear10 <- tesseract::ocr("data/source/images/Bayview_thisyear10.png", engine = eng)
Bayviewtable_thisyear11 <- tesseract::ocr("data/source/images/Bayview_thisyear11.png", engine = eng)
Bayviewtable_thisyear12 <- tesseract::ocr("data/source/images/Bayview_thisyear12.png", engine = eng)
Centraltable_title1 <- tesseract::ocr("data/source/images/Central_title1.png", engine = eng)
Centraltable_title2 <- tesseract::ocr("data/source/images/Central_title2.png", engine = eng)
Centraltable_title3 <- tesseract::ocr("data/source/images/Central_title3.png", engine = eng)
Centraltable_title4 <- tesseract::ocr("data/source/images/Central_title4.png", engine = eng)
Centraltable_title5 <- tesseract::ocr("data/source/images/Central_title5.png", engine = eng)
Centraltable_title6 <- tesseract::ocr("data/source/images/Central_title6.png", engine = eng)
Centraltable_title7 <- tesseract::ocr("data/source/images/Central_title7.png", engine = eng)
Centraltable_title8 <- tesseract::ocr("data/source/images/Central_title8.png", engine = eng)
Centraltable_title9 <- tesseract::ocr("data/source/images/Central_title9.png", engine = eng)
Centraltable_title10 <- tesseract::ocr("data/source/images/Central_title10.png", engine = eng)
Centraltable_title11 <- tesseract::ocr("data/source/images/Central_title11.png", engine = eng)
Centraltable_title12 <- tesseract::ocr("data/source/images/Central_title12.png", engine = eng)
Centraltable_thisyear1 <- tesseract::ocr("data/source/images/Central_thisyear1.png", engine = eng)
Centraltable_thisyear2 <- tesseract::ocr("data/source/images/Central_thisyear2.png", engine = eng)
Centraltable_thisyear3 <- tesseract::ocr("data/source/images/Central_thisyear3.png", engine = eng)
Centraltable_thisyear4 <- tesseract::ocr("data/source/images/Central_thisyear4.png", engine = eng)
Centraltable_thisyear5 <- tesseract::ocr("data/source/images/Central_thisyear5.png", engine = eng)
Centraltable_thisyear6 <- tesseract::ocr("data/source/images/Central_thisyear6.png", engine = eng)
Centraltable_thisyear7 <- tesseract::ocr("data/source/images/Central_thisyear7.png", engine = eng)
Centraltable_thisyear8 <- tesseract::ocr("data/source/images/Central_thisyear8.png", engine = eng)
Centraltable_thisyear9 <- tesseract::ocr("data/source/images/Central_thisyear9.png", engine = eng)
Centraltable_thisyear10 <- tesseract::ocr("data/source/images/Central_thisyear10.png", engine = eng)
Centraltable_thisyear11 <- tesseract::ocr("data/source/images/Central_thisyear11.png", engine = eng)
Centraltable_thisyear12 <- tesseract::ocr("data/source/images/Central_thisyear12.png", engine = eng)
Inglesidetable_title1 <- tesseract::ocr("data/source/images/Ingleside_title1.png", engine = eng)
Inglesidetable_title2 <- tesseract::ocr("data/source/images/Ingleside_title2.png", engine = eng)
Inglesidetable_title3 <- tesseract::ocr("data/source/images/Ingleside_title3.png", engine = eng)
Inglesidetable_title4 <- tesseract::ocr("data/source/images/Ingleside_title4.png", engine = eng)
Inglesidetable_title5 <- tesseract::ocr("data/source/images/Ingleside_title5.png", engine = eng)
Inglesidetable_title6 <- tesseract::ocr("data/source/images/Ingleside_title6.png", engine = eng)
Inglesidetable_title7 <- tesseract::ocr("data/source/images/Ingleside_title7.png", engine = eng)
Inglesidetable_title8 <- tesseract::ocr("data/source/images/Ingleside_title8.png", engine = eng)
Inglesidetable_title9 <- tesseract::ocr("data/source/images/Ingleside_title9.png", engine = eng)
Inglesidetable_title10 <- tesseract::ocr("data/source/images/Ingleside_title10.png", engine = eng)
Inglesidetable_title11 <- tesseract::ocr("data/source/images/Ingleside_title11.png", engine = eng)
Inglesidetable_title12 <- tesseract::ocr("data/source/images/Ingleside_title12.png", engine = eng)
Inglesidetable_thisyear1 <- tesseract::ocr("data/source/images/Ingleside_thisyear1.png", engine = eng)
Inglesidetable_thisyear2 <- tesseract::ocr("data/source/images/Ingleside_thisyear2.png", engine = eng)
Inglesidetable_thisyear3 <- tesseract::ocr("data/source/images/Ingleside_thisyear3.png", engine = eng)
Inglesidetable_thisyear4 <- tesseract::ocr("data/source/images/Ingleside_thisyear4.png", engine = eng)
Inglesidetable_thisyear5 <- tesseract::ocr("data/source/images/Ingleside_thisyear5.png", engine = eng)
Inglesidetable_thisyear6 <- tesseract::ocr("data/source/images/Ingleside_thisyear6.png", engine = eng)
Inglesidetable_thisyear7 <- tesseract::ocr("data/source/images/Ingleside_thisyear7.png", engine = eng)
Inglesidetable_thisyear8 <- tesseract::ocr("data/source/images/Ingleside_thisyear8.png", engine = eng)
Inglesidetable_thisyear9 <- tesseract::ocr("data/source/images/Ingleside_thisyear9.png", engine = eng)
Inglesidetable_thisyear10 <- tesseract::ocr("data/source/images/Ingleside_thisyear10.png", engine = eng)
Inglesidetable_thisyear11 <- tesseract::ocr("data/source/images/Ingleside_thisyear11.png", engine = eng)
Inglesidetable_thisyear12 <- tesseract::ocr("data/source/images/Ingleside_thisyear12.png", engine = eng)
Missiontable_title1 <- tesseract::ocr("data/source/images/Mission_title1.png", engine = eng)
Missiontable_title2 <- tesseract::ocr("data/source/images/Mission_title2.png", engine = eng)
Missiontable_title3 <- tesseract::ocr("data/source/images/Mission_title3.png", engine = eng)
Missiontable_title4 <- tesseract::ocr("data/source/images/Mission_title4.png", engine = eng)
Missiontable_title5 <- tesseract::ocr("data/source/images/Mission_title5.png", engine = eng)
Missiontable_title6 <- tesseract::ocr("data/source/images/Mission_title6.png", engine = eng)
Missiontable_title7 <- tesseract::ocr("data/source/images/Mission_title7.png", engine = eng)
Missiontable_title8 <- tesseract::ocr("data/source/images/Mission_title8.png", engine = eng)
Missiontable_title9 <- tesseract::ocr("data/source/images/Mission_title9.png", engine = eng)
Missiontable_title10 <- tesseract::ocr("data/source/images/Mission_title10.png", engine = eng)
Missiontable_title11 <- tesseract::ocr("data/source/images/Mission_title11.png", engine = eng)
Missiontable_title12 <- tesseract::ocr("data/source/images/Mission_title12.png", engine = eng)
Missiontable_thisyear1 <- tesseract::ocr("data/source/images/Mission_thisyear1.png", engine = eng)
Missiontable_thisyear2 <- tesseract::ocr("data/source/images/Mission_thisyear2.png", engine = eng)
Missiontable_thisyear3 <- tesseract::ocr("data/source/images/Mission_thisyear3.png", engine = eng)
Missiontable_thisyear4 <- tesseract::ocr("data/source/images/Mission_thisyear4.png", engine = eng)
Missiontable_thisyear5 <- tesseract::ocr("data/source/images/Mission_thisyear5.png", engine = eng)
Missiontable_thisyear6 <- tesseract::ocr("data/source/images/Mission_thisyear6.png", engine = eng)
Missiontable_thisyear7 <- tesseract::ocr("data/source/images/Mission_thisyear7.png", engine = eng)
Missiontable_thisyear8 <- tesseract::ocr("data/source/images/Mission_thisyear8.png", engine = eng)
Missiontable_thisyear9 <- tesseract::ocr("data/source/images/Mission_thisyear9.png", engine = eng)
Missiontable_thisyear10 <- tesseract::ocr("data/source/images/Mission_thisyear10.png", engine = eng)
Missiontable_thisyear11 <- tesseract::ocr("data/source/images/Mission_thisyear11.png", engine = eng)
Missiontable_thisyear12 <- tesseract::ocr("data/source/images/Mission_thisyear12.png", engine = eng)
Northerntable_title1 <- tesseract::ocr("data/source/images/Northern_title1.png", engine = eng)
Northerntable_title2 <- tesseract::ocr("data/source/images/Northern_title2.png", engine = eng)
Northerntable_title3 <- tesseract::ocr("data/source/images/Northern_title3.png", engine = eng)
Northerntable_title4 <- tesseract::ocr("data/source/images/Northern_title4.png", engine = eng)
Northerntable_title5 <- tesseract::ocr("data/source/images/Northern_title5.png", engine = eng)
Northerntable_title6 <- tesseract::ocr("data/source/images/Northern_title6.png", engine = eng)
Northerntable_title7 <- tesseract::ocr("data/source/images/Northern_title7.png", engine = eng)
Northerntable_title8 <- tesseract::ocr("data/source/images/Northern_title8.png", engine = eng)
Northerntable_title9 <- tesseract::ocr("data/source/images/Northern_title9.png", engine = eng)
Northerntable_title10 <- tesseract::ocr("data/source/images/Northern_title10.png", engine = eng)
Northerntable_title11 <- tesseract::ocr("data/source/images/Northern_title11.png", engine = eng)
Northerntable_title12 <- tesseract::ocr("data/source/images/Northern_title12.png", engine = eng)
Northerntable_thisyear1 <- tesseract::ocr("data/source/images/Northern_thisyear1.png", engine = eng)
Northerntable_thisyear2 <- tesseract::ocr("data/source/images/Northern_thisyear2.png", engine = eng)
Northerntable_thisyear3 <- tesseract::ocr("data/source/images/Northern_thisyear3.png", engine = eng)
Northerntable_thisyear4 <- tesseract::ocr("data/source/images/Northern_thisyear4.png", engine = eng)
Northerntable_thisyear5 <- tesseract::ocr("data/source/images/Northern_thisyear5.png", engine = eng)
Northerntable_thisyear6 <- tesseract::ocr("data/source/images/Northern_thisyear6.png", engine = eng)
Northerntable_thisyear7 <- tesseract::ocr("data/source/images/Northern_thisyear7.png", engine = eng)
Northerntable_thisyear8 <- tesseract::ocr("data/source/images/Northern_thisyear8.png", engine = eng)
Northerntable_thisyear9 <- tesseract::ocr("data/source/images/Northern_thisyear9.png", engine = eng)
Northerntable_thisyear10 <- tesseract::ocr("data/source/images/Northern_thisyear10.png", engine = eng)
Northerntable_thisyear11 <- tesseract::ocr("data/source/images/Northern_thisyear11.png", engine = eng)
Northerntable_thisyear12 <- tesseract::ocr("data/source/images/Northern_thisyear12.png", engine = eng)
Parktable_title1 <- tesseract::ocr("data/source/images/Park_title1.png", engine = eng)
Parktable_title2 <- tesseract::ocr("data/source/images/Park_title2.png", engine = eng)
Parktable_title3 <- tesseract::ocr("data/source/images/Park_title3.png", engine = eng)
Parktable_title4 <- tesseract::ocr("data/source/images/Park_title4.png", engine = eng)
Parktable_title5 <- tesseract::ocr("data/source/images/Park_title5.png", engine = eng)
Parktable_title6 <- tesseract::ocr("data/source/images/Park_title6.png", engine = eng)
Parktable_title7 <- tesseract::ocr("data/source/images/Park_title7.png", engine = eng)
Parktable_title8 <- tesseract::ocr("data/source/images/Park_title8.png", engine = eng)
Parktable_title9 <- tesseract::ocr("data/source/images/Park_title9.png", engine = eng)
Parktable_title10 <- tesseract::ocr("data/source/images/Park_title10.png", engine = eng)
Parktable_title11 <- tesseract::ocr("data/source/images/Park_title11.png", engine = eng)
Parktable_title12 <- tesseract::ocr("data/source/images/Park_title12.png", engine = eng)
Parktable_thisyear1 <- tesseract::ocr("data/source/images/Park_thisyear1.png", engine = eng)
Parktable_thisyear2 <- tesseract::ocr("data/source/images/Park_thisyear2.png", engine = eng)
Parktable_thisyear3 <- tesseract::ocr("data/source/images/Park_thisyear3.png", engine = eng)
Parktable_thisyear4 <- tesseract::ocr("data/source/images/Park_thisyear4.png", engine = eng)
Parktable_thisyear5 <- tesseract::ocr("data/source/images/Park_thisyear5.png", engine = eng)
Parktable_thisyear6 <- tesseract::ocr("data/source/images/Park_thisyear6.png", engine = eng)
Parktable_thisyear7 <- tesseract::ocr("data/source/images/Park_thisyear7.png", engine = eng)
Parktable_thisyear8 <- tesseract::ocr("data/source/images/Park_thisyear8.png", engine = eng)
Parktable_thisyear9 <- tesseract::ocr("data/source/images/Park_thisyear9.png", engine = eng)
Parktable_thisyear10 <- tesseract::ocr("data/source/images/Park_thisyear10.png", engine = eng)
Parktable_thisyear11 <- tesseract::ocr("data/source/images/Park_thisyear11.png", engine = eng)
Parktable_thisyear12 <- tesseract::ocr("data/source/images/Park_thisyear12.png", engine = eng)
Richmondtable_title1 <- tesseract::ocr("data/source/images/Richmond_title1.png", engine = eng)
Richmondtable_title2 <- tesseract::ocr("data/source/images/Richmond_title2.png", engine = eng)
Richmondtable_title3 <- tesseract::ocr("data/source/images/Richmond_title3.png", engine = eng)
Richmondtable_title4 <- tesseract::ocr("data/source/images/Richmond_title4.png", engine = eng)
Richmondtable_title5 <- tesseract::ocr("data/source/images/Richmond_title5.png", engine = eng)
Richmondtable_title6 <- tesseract::ocr("data/source/images/Richmond_title6.png", engine = eng)
Richmondtable_title7 <- tesseract::ocr("data/source/images/Richmond_title7.png", engine = eng)
Richmondtable_title8 <- tesseract::ocr("data/source/images/Richmond_title8.png", engine = eng)
Richmondtable_title9 <- tesseract::ocr("data/source/images/Richmond_title9.png", engine = eng)
Richmondtable_title10 <- tesseract::ocr("data/source/images/Richmond_title10.png", engine = eng)
Richmondtable_title11 <- tesseract::ocr("data/source/images/Richmond_title11.png", engine = eng)
Richmondtable_title12 <- tesseract::ocr("data/source/images/Richmond_title12.png", engine = eng)
Richmondtable_thisyear1 <- tesseract::ocr("data/source/images/Richmond_thisyear1.png", engine = eng)
Richmondtable_thisyear2 <- tesseract::ocr("data/source/images/Richmond_thisyear2.png", engine = eng)
Richmondtable_thisyear3 <- tesseract::ocr("data/source/images/Richmond_thisyear3.png", engine = eng)
Richmondtable_thisyear4 <- tesseract::ocr("data/source/images/Richmond_thisyear4.png", engine = eng)
Richmondtable_thisyear5 <- tesseract::ocr("data/source/images/Richmond_thisyear5.png", engine = eng)
Richmondtable_thisyear6 <- tesseract::ocr("data/source/images/Richmond_thisyear6.png", engine = eng)
Richmondtable_thisyear7 <- tesseract::ocr("data/source/images/Richmond_thisyear7.png", engine = eng)
Richmondtable_thisyear8 <- tesseract::ocr("data/source/images/Richmond_thisyear8.png", engine = eng)
Richmondtable_thisyear9 <- tesseract::ocr("data/source/images/Richmond_thisyear9.png", engine = eng)
Richmondtable_thisyear10 <- tesseract::ocr("data/source/images/Richmond_thisyear10.png", engine = eng)
Richmondtable_thisyear11 <- tesseract::ocr("data/source/images/Richmond_thisyear11.png", engine = eng)
Richmondtable_thisyear12 <- tesseract::ocr("data/source/images/Richmond_thisyear12.png", engine = eng)
Southerntable_title1 <- tesseract::ocr("data/source/images/Southern_title1.png", engine = eng)
Southerntable_title2 <- tesseract::ocr("data/source/images/Southern_title2.png", engine = eng)
Southerntable_title3 <- tesseract::ocr("data/source/images/Southern_title3.png", engine = eng)
Southerntable_title4 <- tesseract::ocr("data/source/images/Southern_title4.png", engine = eng)
Southerntable_title5 <- tesseract::ocr("data/source/images/Southern_title5.png", engine = eng)
Southerntable_title6 <- tesseract::ocr("data/source/images/Southern_title6.png", engine = eng)
Southerntable_title7 <- tesseract::ocr("data/source/images/Southern_title7.png", engine = eng)
Southerntable_title8 <- tesseract::ocr("data/source/images/Southern_title8.png", engine = eng)
Southerntable_title9 <- tesseract::ocr("data/source/images/Southern_title9.png", engine = eng)
Southerntable_title10 <- tesseract::ocr("data/source/images/Southern_title10.png", engine = eng)
Southerntable_title11 <- tesseract::ocr("data/source/images/Southern_title11.png", engine = eng)
Southerntable_title12 <- tesseract::ocr("data/source/images/Southern_title12.png", engine = eng)
Southerntable_thisyear1 <- tesseract::ocr("data/source/images/Southern_thisyear1.png", engine = eng)
Southerntable_thisyear2 <- tesseract::ocr("data/source/images/Southern_thisyear2.png", engine = eng)
Southerntable_thisyear3 <- tesseract::ocr("data/source/images/Southern_thisyear3.png", engine = eng)
Southerntable_thisyear4 <- tesseract::ocr("data/source/images/Southern_thisyear4.png", engine = eng)
Southerntable_thisyear5 <- tesseract::ocr("data/source/images/Southern_thisyear5.png", engine = eng)
Southerntable_thisyear6 <- tesseract::ocr("data/source/images/Southern_thisyear6.png", engine = eng)
Southerntable_thisyear7 <- tesseract::ocr("data/source/images/Southern_thisyear7.png", engine = eng)
Southerntable_thisyear8 <- tesseract::ocr("data/source/images/Southern_thisyear8.png", engine = eng)
Southerntable_thisyear9 <- tesseract::ocr("data/source/images/Southern_thisyear9.png", engine = eng)
Southerntable_thisyear10 <- tesseract::ocr("data/source/images/Southern_thisyear10.png", engine = eng)
Southerntable_thisyear11 <- tesseract::ocr("data/source/images/Southern_thisyear11.png", engine = eng)
Southerntable_thisyear12 <- tesseract::ocr("data/source/images/Southern_thisyear12.png", engine = eng)
Taravaltable_title1 <- tesseract::ocr("data/source/images/Taraval_title1.png", engine = eng)
Taravaltable_title2 <- tesseract::ocr("data/source/images/Taraval_title2.png", engine = eng)
Taravaltable_title3 <- tesseract::ocr("data/source/images/Taraval_title3.png", engine = eng)
Taravaltable_title4 <- tesseract::ocr("data/source/images/Taraval_title4.png", engine = eng)
Taravaltable_title5 <- tesseract::ocr("data/source/images/Taraval_title5.png", engine = eng)
Taravaltable_title6 <- tesseract::ocr("data/source/images/Taraval_title6.png", engine = eng)
Taravaltable_title7 <- tesseract::ocr("data/source/images/Taraval_title7.png", engine = eng)
Taravaltable_title8 <- tesseract::ocr("data/source/images/Taraval_title8.png", engine = eng)
Taravaltable_title9 <- tesseract::ocr("data/source/images/Taraval_title9.png", engine = eng)
Taravaltable_title10 <- tesseract::ocr("data/source/images/Taraval_title10.png", engine = eng)
Taravaltable_title11 <- tesseract::ocr("data/source/images/Taraval_title11.png", engine = eng)
Taravaltable_title12 <- tesseract::ocr("data/source/images/Taraval_title12.png", engine = eng)
Taravaltable_thisyear1 <- tesseract::ocr("data/source/images/Taraval_thisyear1.png", engine = eng)
Taravaltable_thisyear2 <- tesseract::ocr("data/source/images/Taraval_thisyear2.png", engine = eng)
Taravaltable_thisyear3 <- tesseract::ocr("data/source/images/Taraval_thisyear3.png", engine = eng)
Taravaltable_thisyear4 <- tesseract::ocr("data/source/images/Taraval_thisyear4.png", engine = eng)
Taravaltable_thisyear5 <- tesseract::ocr("data/source/images/Taraval_thisyear5.png", engine = eng)
Taravaltable_thisyear6 <- tesseract::ocr("data/source/images/Taraval_thisyear6.png", engine = eng)
Taravaltable_thisyear7 <- tesseract::ocr("data/source/images/Taraval_thisyear7.png", engine = eng)
Taravaltable_thisyear8 <- tesseract::ocr("data/source/images/Taraval_thisyear8.png", engine = eng)
Taravaltable_thisyear9 <- tesseract::ocr("data/source/images/Taraval_thisyear9.png", engine = eng)
Taravaltable_thisyear10 <- tesseract::ocr("data/source/images/Taraval_thisyear10.png", engine = eng)
Taravaltable_thisyear11 <- tesseract::ocr("data/source/images/Taraval_thisyear11.png", engine = eng)
Taravaltable_thisyear12 <- tesseract::ocr("data/source/images/Taraval_thisyear12.png", engine = eng)
Tenderlointable_title1 <- tesseract::ocr("data/source/images/Tenderloin_title1.png", engine = eng)
Tenderlointable_title2 <- tesseract::ocr("data/source/images/Tenderloin_title2.png", engine = eng)
Tenderlointable_title3 <- tesseract::ocr("data/source/images/Tenderloin_title3.png", engine = eng)
Tenderlointable_title4 <- tesseract::ocr("data/source/images/Tenderloin_title4.png", engine = eng)
Tenderlointable_title5 <- tesseract::ocr("data/source/images/Tenderloin_title5.png", engine = eng)
Tenderlointable_title6 <- tesseract::ocr("data/source/images/Tenderloin_title6.png", engine = eng)
Tenderlointable_title7 <- tesseract::ocr("data/source/images/Tenderloin_title7.png", engine = eng)
Tenderlointable_title8 <- tesseract::ocr("data/source/images/Tenderloin_title8.png", engine = eng)
Tenderlointable_title9 <- tesseract::ocr("data/source/images/Tenderloin_title9.png", engine = eng)
Tenderlointable_title10 <- tesseract::ocr("data/source/images/Tenderloin_title10.png", engine = eng)
Tenderlointable_title11 <- tesseract::ocr("data/source/images/Tenderloin_title11.png", engine = eng)
Tenderlointable_title12 <- tesseract::ocr("data/source/images/Tenderloin_title12.png", engine = eng)
Tenderlointable_thisyear1 <- tesseract::ocr("data/source/images/Tenderloin_thisyear1.png", engine = eng)
Tenderlointable_thisyear2 <- tesseract::ocr("data/source/images/Tenderloin_thisyear2.png", engine = eng)
Tenderlointable_thisyear3 <- tesseract::ocr("data/source/images/Tenderloin_thisyear3.png", engine = eng)
Tenderlointable_thisyear4 <- tesseract::ocr("data/source/images/Tenderloin_thisyear4.png", engine = eng)
Tenderlointable_thisyear5 <- tesseract::ocr("data/source/images/Tenderloin_thisyear5.png", engine = eng)
Tenderlointable_thisyear6 <- tesseract::ocr("data/source/images/Tenderloin_thisyear6.png", engine = eng)
Tenderlointable_thisyear7 <- tesseract::ocr("data/source/images/Tenderloin_thisyear7.png", engine = eng)
Tenderlointable_thisyear8 <- tesseract::ocr("data/source/images/Tenderloin_thisyear8.png", engine = eng)
Tenderlointable_thisyear9 <- tesseract::ocr("data/source/images/Tenderloin_thisyear9.png", engine = eng)
Tenderlointable_thisyear10 <- tesseract::ocr("data/source/images/Tenderloin_thisyear10.png", engine = eng)
Tenderlointable_thisyear11 <- tesseract::ocr("data/source/images/Tenderloin_thisyear11.png", engine = eng)
Tenderlointable_thisyear12 <- tesseract::ocr("data/source/images/Tenderloin_thisyear12.png", engine = eng)

###
# Building a series of tibbles from the text ocr from individual cell images
SFtable_update<- gsub("\n","",SFtable_update)
SFtable_title1 <- gsub("\n","",SFtable_title1)
SFtable_title2 <- gsub("\n","",SFtable_title2)
SFtable_title3 <- gsub("\n","",SFtable_title3)
SFtable_title4 <- gsub("\n","",SFtable_title4)
SFtable_title5 <- gsub("\n","",SFtable_title5)
SFtable_title6 <- gsub("\n","",SFtable_title6)
SFtable_title7 <- gsub("\n","",SFtable_title7)
SFtable_title8 <- gsub("\n","",SFtable_title8)
SFtable_title9 <- gsub("\n","",SFtable_title9)
SFtable_title10 <- gsub("\n","",SFtable_title10)
SFtable_title11 <- gsub("\n","",SFtable_title11)
SFtable_title12 <- gsub("\n","",SFtable_title12)
SFtable_thisyear1 <- gsub("\n","",SFtable_thisyear1)
SFtable_thisyear2 <- gsub("\n","",SFtable_thisyear2)
SFtable_thisyear3 <- gsub("\n","",SFtable_thisyear3)
SFtable_thisyear4 <- gsub("\n","",SFtable_thisyear4)
SFtable_thisyear5 <- gsub("\n","",SFtable_thisyear5)
SFtable_thisyear6 <- gsub("\n","",SFtable_thisyear6)
SFtable_thisyear7 <- gsub("\n","",SFtable_thisyear7)
SFtable_thisyear8 <- gsub("\n","",SFtable_thisyear8)
SFtable_thisyear9 <- gsub("\n","",SFtable_thisyear9)
SFtable_thisyear10 <- gsub("\n","",SFtable_thisyear10)
SFtable_thisyear11 <- gsub("\n","",SFtable_thisyear11)
SFtable_thisyear12 <- gsub("\n","",SFtable_thisyear12)

Bayviewtable_title1 <- gsub("\n","",Bayviewtable_title1)
Bayviewtable_title2 <- gsub("\n","",Bayviewtable_title2)
Bayviewtable_title3 <- gsub("\n","",Bayviewtable_title3)
Bayviewtable_title4 <- gsub("\n","",Bayviewtable_title4)
Bayviewtable_title5 <- gsub("\n","",Bayviewtable_title5)
Bayviewtable_title6 <- gsub("\n","",Bayviewtable_title6)
Bayviewtable_title7 <- gsub("\n","",Bayviewtable_title7)
Bayviewtable_title8 <- gsub("\n","",Bayviewtable_title8)
Bayviewtable_title9 <- gsub("\n","",Bayviewtable_title9)
Bayviewtable_title10 <- gsub("\n","",Bayviewtable_title10)
Bayviewtable_title11 <- gsub("\n","",Bayviewtable_title11)
Bayviewtable_title12 <- gsub("\n","",Bayviewtable_title12)

Bayviewtable_thisyear1 <- gsub("\n","",Bayviewtable_thisyear1)
Bayviewtable_thisyear2 <- gsub("\n","",Bayviewtable_thisyear2)
Bayviewtable_thisyear3 <- gsub("\n","",Bayviewtable_thisyear3)
Bayviewtable_thisyear4 <- gsub("\n","",Bayviewtable_thisyear4)
Bayviewtable_thisyear5 <- gsub("\n","",Bayviewtable_thisyear5)
Bayviewtable_thisyear6 <- gsub("\n","",Bayviewtable_thisyear6)
Bayviewtable_thisyear7 <- gsub("\n","",Bayviewtable_thisyear7)
Bayviewtable_thisyear8 <- gsub("\n","",Bayviewtable_thisyear8)
Bayviewtable_thisyear9 <- gsub("\n","",Bayviewtable_thisyear9)
Bayviewtable_thisyear10 <- gsub("\n","",Bayviewtable_thisyear10)
Bayviewtable_thisyear11 <- gsub("\n","",Bayviewtable_thisyear11)
Bayviewtable_thisyear12 <- gsub("\n","",Bayviewtable_thisyear12)

Centraltable_title1 <- gsub("\n","",Centraltable_title1)
Centraltable_title2 <- gsub("\n","",Centraltable_title2)
Centraltable_title3 <- gsub("\n","",Centraltable_title3)
Centraltable_title4 <- gsub("\n","",Centraltable_title4)
Centraltable_title5 <- gsub("\n","",Centraltable_title5)
Centraltable_title6 <- gsub("\n","",Centraltable_title6)
Centraltable_title7 <- gsub("\n","",Centraltable_title7)
Centraltable_title8 <- gsub("\n","",Centraltable_title8)
Centraltable_title9 <- gsub("\n","",Centraltable_title9)
Centraltable_title10 <- gsub("\n","",Centraltable_title10)
Centraltable_title11 <- gsub("\n","",Centraltable_title11)
Centraltable_title12 <- gsub("\n","",Centraltable_title12)

Centraltable_thisyear1 <- gsub("\n","",Centraltable_thisyear1)
Centraltable_thisyear2 <- gsub("\n","",Centraltable_thisyear2)
Centraltable_thisyear3 <- gsub("\n","",Centraltable_thisyear3)
Centraltable_thisyear4 <- gsub("\n","",Centraltable_thisyear4)
Centraltable_thisyear5 <- gsub("\n","",Centraltable_thisyear5)
Centraltable_thisyear6 <- gsub("\n","",Centraltable_thisyear6)
Centraltable_thisyear7 <- gsub("\n","",Centraltable_thisyear7)
Centraltable_thisyear8 <- gsub("\n","",Centraltable_thisyear8)
Centraltable_thisyear9 <- gsub("\n","",Centraltable_thisyear9)
Centraltable_thisyear10 <- gsub("\n","",Centraltable_thisyear10)
Centraltable_thisyear11 <- gsub("\n","",Centraltable_thisyear11)
Centraltable_thisyear12 <- gsub("\n","",Centraltable_thisyear12)

Inglesidetable_title1 <- gsub("\n","",Inglesidetable_title1)
Inglesidetable_title2 <- gsub("\n","",Inglesidetable_title2)
Inglesidetable_title3 <- gsub("\n","",Inglesidetable_title3)
Inglesidetable_title4 <- gsub("\n","",Inglesidetable_title4)
Inglesidetable_title5 <- gsub("\n","",Inglesidetable_title5)
Inglesidetable_title6 <- gsub("\n","",Inglesidetable_title6)
Inglesidetable_title7 <- gsub("\n","",Inglesidetable_title7)
Inglesidetable_title8 <- gsub("\n","",Inglesidetable_title8)
Inglesidetable_title9 <- gsub("\n","",Inglesidetable_title9)
Inglesidetable_title10 <- gsub("\n","",Inglesidetable_title10)
Inglesidetable_title11 <- gsub("\n","",Inglesidetable_title11)
Inglesidetable_title12 <- gsub("\n","",Inglesidetable_title12)

Inglesidetable_thisyear1 <- gsub("\n","",Inglesidetable_thisyear1)
Inglesidetable_thisyear2 <- gsub("\n","",Inglesidetable_thisyear2)
Inglesidetable_thisyear3 <- gsub("\n","",Inglesidetable_thisyear3)
Inglesidetable_thisyear4 <- gsub("\n","",Inglesidetable_thisyear4)
Inglesidetable_thisyear5 <- gsub("\n","",Inglesidetable_thisyear5)
Inglesidetable_thisyear6 <- gsub("\n","",Inglesidetable_thisyear6)
Inglesidetable_thisyear7 <- gsub("\n","",Inglesidetable_thisyear7)
Inglesidetable_thisyear8 <- gsub("\n","",Inglesidetable_thisyear8)
Inglesidetable_thisyear9 <- gsub("\n","",Inglesidetable_thisyear9)
Inglesidetable_thisyear10 <- gsub("\n","",Inglesidetable_thisyear10)
Inglesidetable_thisyear11 <- gsub("\n","",Inglesidetable_thisyear11)
Inglesidetable_thisyear12 <- gsub("\n","",Inglesidetable_thisyear12)

Missiontable_title1 <- gsub("\n","",Missiontable_title1)
Missiontable_title2 <- gsub("\n","",Missiontable_title2)
Missiontable_title3 <- gsub("\n","",Missiontable_title3)
Missiontable_title4 <- gsub("\n","",Missiontable_title4)
Missiontable_title5 <- gsub("\n","",Missiontable_title5)
Missiontable_title6 <- gsub("\n","",Missiontable_title6)
Missiontable_title7 <- gsub("\n","",Missiontable_title7)
Missiontable_title8 <- gsub("\n","",Missiontable_title8)
Missiontable_title9 <- gsub("\n","",Missiontable_title9)
Missiontable_title10 <- gsub("\n","",Missiontable_title10)
Missiontable_title11 <- gsub("\n","",Missiontable_title11)
Missiontable_title12 <- gsub("\n","",Missiontable_title12)

Missiontable_thisyear1 <- gsub("\n","",Missiontable_thisyear1)
Missiontable_thisyear2 <- gsub("\n","",Missiontable_thisyear2)
Missiontable_thisyear3 <- gsub("\n","",Missiontable_thisyear3)
Missiontable_thisyear4 <- gsub("\n","",Missiontable_thisyear4)
Missiontable_thisyear5 <- gsub("\n","",Missiontable_thisyear5)
Missiontable_thisyear6 <- gsub("\n","",Missiontable_thisyear6)
Missiontable_thisyear7 <- gsub("\n","",Missiontable_thisyear7)
Missiontable_thisyear8 <- gsub("\n","",Missiontable_thisyear8)
Missiontable_thisyear9 <- gsub("\n","",Missiontable_thisyear9)
Missiontable_thisyear10 <- gsub("\n","",Missiontable_thisyear10)
Missiontable_thisyear11 <- gsub("\n","",Missiontable_thisyear11)
Missiontable_thisyear12 <- gsub("\n","",Missiontable_thisyear12)

Northerntable_title1 <- gsub("\n","",Northerntable_title1)
Northerntable_title2 <- gsub("\n","",Northerntable_title2)
Northerntable_title3 <- gsub("\n","",Northerntable_title3)
Northerntable_title4 <- gsub("\n","",Northerntable_title4)
Northerntable_title5 <- gsub("\n","",Northerntable_title5)
Northerntable_title6 <- gsub("\n","",Northerntable_title6)
Northerntable_title7 <- gsub("\n","",Northerntable_title7)
Northerntable_title8 <- gsub("\n","",Northerntable_title8)
Northerntable_title9 <- gsub("\n","",Northerntable_title9)
Northerntable_title10 <- gsub("\n","",Northerntable_title10)
Northerntable_title11 <- gsub("\n","",Northerntable_title11)
Northerntable_title12 <- gsub("\n","",Northerntable_title12)

Northerntable_thisyear1 <- gsub("\n","",Northerntable_thisyear1)
Northerntable_thisyear2 <- gsub("\n","",Northerntable_thisyear2)
Northerntable_thisyear3 <- gsub("\n","",Northerntable_thisyear3)
Northerntable_thisyear4 <- gsub("\n","",Northerntable_thisyear4)
Northerntable_thisyear5 <- gsub("\n","",Northerntable_thisyear5)
Northerntable_thisyear6 <- gsub("\n","",Northerntable_thisyear6)
Northerntable_thisyear7 <- gsub("\n","",Northerntable_thisyear7)
Northerntable_thisyear8 <- gsub("\n","",Northerntable_thisyear8)
Northerntable_thisyear9 <- gsub("\n","",Northerntable_thisyear9)
Northerntable_thisyear10 <- gsub("\n","",Northerntable_thisyear10)
Northerntable_thisyear11 <- gsub("\n","",Northerntable_thisyear11)
Northerntable_thisyear12 <- gsub("\n","",Northerntable_thisyear12)

Parktable_title1 <- gsub("\n","",Parktable_title1)
Parktable_title2 <- gsub("\n","",Parktable_title2)
Parktable_title3 <- gsub("\n","",Parktable_title3)
Parktable_title4 <- gsub("\n","",Parktable_title4)
Parktable_title5 <- gsub("\n","",Parktable_title5)
Parktable_title6 <- gsub("\n","",Parktable_title6)
Parktable_title7 <- gsub("\n","",Parktable_title7)
Parktable_title8 <- gsub("\n","",Parktable_title8)
Parktable_title9 <- gsub("\n","",Parktable_title9)
Parktable_title10 <- gsub("\n","",Parktable_title10)
Parktable_title11 <- gsub("\n","",Parktable_title11)
Parktable_title12 <- gsub("\n","",Parktable_title12)

Parktable_thisyear1 <- gsub("\n","",Parktable_thisyear1)
Parktable_thisyear2 <- gsub("\n","",Parktable_thisyear2)
Parktable_thisyear3 <- gsub("\n","",Parktable_thisyear3)
Parktable_thisyear4 <- gsub("\n","",Parktable_thisyear4)
Parktable_thisyear5 <- gsub("\n","",Parktable_thisyear5)
Parktable_thisyear6 <- gsub("\n","",Parktable_thisyear6)
Parktable_thisyear7 <- gsub("\n","",Parktable_thisyear7)
Parktable_thisyear8 <- gsub("\n","",Parktable_thisyear8)
Parktable_thisyear9 <- gsub("\n","",Parktable_thisyear9)
Parktable_thisyear10 <- gsub("\n","",Parktable_thisyear10)
Parktable_thisyear11 <- gsub("\n","",Parktable_thisyear11)
Parktable_thisyear12 <- gsub("\n","",Parktable_thisyear12)

Richmondtable_title1 <- gsub("\n","",Richmondtable_title1)
Richmondtable_title2 <- gsub("\n","",Richmondtable_title2)
Richmondtable_title3 <- gsub("\n","",Richmondtable_title3)
Richmondtable_title4 <- gsub("\n","",Richmondtable_title4)
Richmondtable_title5 <- gsub("\n","",Richmondtable_title5)
Richmondtable_title6 <- gsub("\n","",Richmondtable_title6)
Richmondtable_title7 <- gsub("\n","",Richmondtable_title7)
Richmondtable_title8 <- gsub("\n","",Richmondtable_title8)
Richmondtable_title9 <- gsub("\n","",Richmondtable_title9)
Richmondtable_title10 <- gsub("\n","",Richmondtable_title10)
Richmondtable_title11 <- gsub("\n","",Richmondtable_title11)
Richmondtable_title12 <- gsub("\n","",Richmondtable_title12)

Richmondtable_thisyear1 <- gsub("\n","",Richmondtable_thisyear1)
Richmondtable_thisyear2 <- gsub("\n","",Richmondtable_thisyear2)
Richmondtable_thisyear3 <- gsub("\n","",Richmondtable_thisyear3)
Richmondtable_thisyear4 <- gsub("\n","",Richmondtable_thisyear4)
Richmondtable_thisyear5 <- gsub("\n","",Richmondtable_thisyear5)
Richmondtable_thisyear6 <- gsub("\n","",Richmondtable_thisyear6)
Richmondtable_thisyear7 <- gsub("\n","",Richmondtable_thisyear7)
Richmondtable_thisyear8 <- gsub("\n","",Richmondtable_thisyear8)
Richmondtable_thisyear9 <- gsub("\n","",Richmondtable_thisyear9)
Richmondtable_thisyear10 <- gsub("\n","",Richmondtable_thisyear10)
Richmondtable_thisyear11 <- gsub("\n","",Richmondtable_thisyear11)
Richmondtable_thisyear12 <- gsub("\n","",Richmondtable_thisyear12)

Southerntable_title1 <- gsub("\n","",Southerntable_title1)
Southerntable_title2 <- gsub("\n","",Southerntable_title2)
Southerntable_title3 <- gsub("\n","",Southerntable_title3)
Southerntable_title4 <- gsub("\n","",Southerntable_title4)
Southerntable_title5 <- gsub("\n","",Southerntable_title5)
Southerntable_title6 <- gsub("\n","",Southerntable_title6)
Southerntable_title7 <- gsub("\n","",Southerntable_title7)
Southerntable_title8 <- gsub("\n","",Southerntable_title8)
Southerntable_title9 <- gsub("\n","",Southerntable_title9)
Southerntable_title10 <- gsub("\n","",Southerntable_title10)
Southerntable_title11 <- gsub("\n","",Southerntable_title11)
Southerntable_title12 <- gsub("\n","",Southerntable_title12)

Southerntable_thisyear1 <- gsub("\n","",Southerntable_thisyear1)
Southerntable_thisyear2 <- gsub("\n","",Southerntable_thisyear2)
Southerntable_thisyear3 <- gsub("\n","",Southerntable_thisyear3)
Southerntable_thisyear4 <- gsub("\n","",Southerntable_thisyear4)
Southerntable_thisyear5 <- gsub("\n","",Southerntable_thisyear5)
Southerntable_thisyear6 <- gsub("\n","",Southerntable_thisyear6)
Southerntable_thisyear7 <- gsub("\n","",Southerntable_thisyear7)
Southerntable_thisyear8 <- gsub("\n","",Southerntable_thisyear8)
Southerntable_thisyear9 <- gsub("\n","",Southerntable_thisyear9)
Southerntable_thisyear10 <- gsub("\n","",Southerntable_thisyear10)
Southerntable_thisyear11 <- gsub("\n","",Southerntable_thisyear11)
Southerntable_thisyear12 <- gsub("\n","",Southerntable_thisyear12)

Taravaltable_title1 <- gsub("\n","",Taravaltable_title1)
Taravaltable_title2 <- gsub("\n","",Taravaltable_title2)
Taravaltable_title3 <- gsub("\n","",Taravaltable_title3)
Taravaltable_title4 <- gsub("\n","",Taravaltable_title4)
Taravaltable_title5 <- gsub("\n","",Taravaltable_title5)
Taravaltable_title6 <- gsub("\n","",Taravaltable_title6)
Taravaltable_title7 <- gsub("\n","",Taravaltable_title7)
Taravaltable_title8 <- gsub("\n","",Taravaltable_title8)
Taravaltable_title9 <- gsub("\n","",Taravaltable_title9)
Taravaltable_title10 <- gsub("\n","",Taravaltable_title10)
Taravaltable_title11 <- gsub("\n","",Taravaltable_title11)
Taravaltable_title12 <- gsub("\n","",Taravaltable_title12)

Taravaltable_thisyear1 <- gsub("\n","",Taravaltable_thisyear1)
Taravaltable_thisyear2 <- gsub("\n","",Taravaltable_thisyear2)
Taravaltable_thisyear3 <- gsub("\n","",Taravaltable_thisyear3)
Taravaltable_thisyear4 <- gsub("\n","",Taravaltable_thisyear4)
Taravaltable_thisyear5 <- gsub("\n","",Taravaltable_thisyear5)
Taravaltable_thisyear6 <- gsub("\n","",Taravaltable_thisyear6)
Taravaltable_thisyear7 <- gsub("\n","",Taravaltable_thisyear7)
Taravaltable_thisyear8 <- gsub("\n","",Taravaltable_thisyear8)
Taravaltable_thisyear9 <- gsub("\n","",Taravaltable_thisyear9)
Taravaltable_thisyear10 <- gsub("\n","",Taravaltable_thisyear10)
Taravaltable_thisyear11 <- gsub("\n","",Taravaltable_thisyear11)
Taravaltable_thisyear12 <- gsub("\n","",Taravaltable_thisyear12)

Tenderlointable_title1 <- gsub("\n","",Tenderlointable_title1)
Tenderlointable_title2 <- gsub("\n","",Tenderlointable_title2)
Tenderlointable_title3 <- gsub("\n","",Tenderlointable_title3)
Tenderlointable_title4 <- gsub("\n","",Tenderlointable_title4)
Tenderlointable_title5 <- gsub("\n","",Tenderlointable_title5)
Tenderlointable_title6 <- gsub("\n","",Tenderlointable_title6)
Tenderlointable_title7 <- gsub("\n","",Tenderlointable_title7)
Tenderlointable_title8 <- gsub("\n","",Tenderlointable_title8)
Tenderlointable_title9 <- gsub("\n","",Tenderlointable_title9)
Tenderlointable_title10 <- gsub("\n","",Tenderlointable_title10)
Tenderlointable_title11 <- gsub("\n","",Tenderlointable_title11)
Tenderlointable_title12 <- gsub("\n","",Tenderlointable_title12)

Tenderlointable_thisyear1 <- gsub("\n","",Tenderlointable_thisyear1)
Tenderlointable_thisyear2 <- gsub("\n","",Tenderlointable_thisyear2)
Tenderlointable_thisyear3 <- gsub("\n","",Tenderlointable_thisyear3)
Tenderlointable_thisyear4 <- gsub("\n","",Tenderlointable_thisyear4)
Tenderlointable_thisyear5 <- gsub("\n","",Tenderlointable_thisyear5)
Tenderlointable_thisyear6 <- gsub("\n","",Tenderlointable_thisyear6)
Tenderlointable_thisyear7 <- gsub("\n","",Tenderlointable_thisyear7)
Tenderlointable_thisyear8 <- gsub("\n","",Tenderlointable_thisyear8)
Tenderlointable_thisyear9 <- gsub("\n","",Tenderlointable_thisyear9)
Tenderlointable_thisyear10 <- gsub("\n","",Tenderlointable_thisyear10)
Tenderlointable_thisyear11 <- gsub("\n","",Tenderlointable_thisyear11)
Tenderlointable_thisyear12 <- gsub("\n","",Tenderlointable_thisyear12)

# combine into list of lists, then data.frame
sf_scraped_list <- list(c('Citywide',SFtable_title1,SFtable_thisyear1),
                        c('Citywide',SFtable_title2,SFtable_thisyear2),
                        c('Citywide',SFtable_title3,SFtable_thisyear3),
                        c('Citywide',SFtable_title4,SFtable_thisyear4),
                        c('Citywide',SFtable_title5,SFtable_thisyear5),
                        c('Citywide',SFtable_title6,SFtable_thisyear6),
                        c('Citywide',SFtable_title7,SFtable_thisyear7),
                        c('Citywide',SFtable_title8,SFtable_thisyear8),
                        c('Citywide',SFtable_title9,SFtable_thisyear9),
                        c('Citywide',SFtable_title10,SFtable_thisyear10),
                        c('Citywide',SFtable_title11,SFtable_thisyear11),
                        c('Citywide',SFtable_title12,SFtable_thisyear12),
                        c('Bayview',Bayviewtable_title1,Bayviewtable_thisyear1),
                        c('Bayview',Bayviewtable_title2,Bayviewtable_thisyear2),
                        c('Bayview',Bayviewtable_title3,Bayviewtable_thisyear3),
                        c('Bayview',Bayviewtable_title4,Bayviewtable_thisyear4),
                        c('Bayview',Bayviewtable_title5,Bayviewtable_thisyear5),
                        c('Bayview',Bayviewtable_title6,Bayviewtable_thisyear6),
                        c('Bayview',Bayviewtable_title7,Bayviewtable_thisyear7),
                        c('Bayview',Bayviewtable_title8,Bayviewtable_thisyear8),
                        c('Bayview',Bayviewtable_title9,Bayviewtable_thisyear9),
                        c('Bayview',Bayviewtable_title10,Bayviewtable_thisyear10),
                        c('Bayview',Bayviewtable_title11,Bayviewtable_thisyear11),
                        c('Bayview',Bayviewtable_title12,Bayviewtable_thisyear12),
                        c('Central',Centraltable_title1,Centraltable_thisyear1),
                        c('Central',Centraltable_title2,Centraltable_thisyear2),
                        c('Central',Centraltable_title3,Centraltable_thisyear3),
                        c('Central',Centraltable_title4,Centraltable_thisyear4),
                        c('Central',Centraltable_title5,Centraltable_thisyear5),
                        c('Central',Centraltable_title6,Centraltable_thisyear6),
                        c('Central',Centraltable_title7,Centraltable_thisyear7),
                        c('Central',Centraltable_title8,Centraltable_thisyear8),
                        c('Central',Centraltable_title9,Centraltable_thisyear9),
                        c('Central',Centraltable_title10,Centraltable_thisyear10),
                        c('Central',Centraltable_title11,Centraltable_thisyear11),
                        c('Central',Centraltable_title12,Centraltable_thisyear12),
                        c('Ingleside',Inglesidetable_title1,Inglesidetable_thisyear1),
                        c('Ingleside',Inglesidetable_title2,Inglesidetable_thisyear2),
                        c('Ingleside',Inglesidetable_title3,Inglesidetable_thisyear3),
                        c('Ingleside',Inglesidetable_title4,Inglesidetable_thisyear4),
                        c('Ingleside',Inglesidetable_title5,Inglesidetable_thisyear5),
                        c('Ingleside',Inglesidetable_title6,Inglesidetable_thisyear6),
                        c('Ingleside',Inglesidetable_title7,Inglesidetable_thisyear7),
                        c('Ingleside',Inglesidetable_title8,Inglesidetable_thisyear8),
                        c('Ingleside',Inglesidetable_title9,Inglesidetable_thisyear9),
                        c('Ingleside',Inglesidetable_title10,Inglesidetable_thisyear10),
                        c('Ingleside',Inglesidetable_title11,Inglesidetable_thisyear11),
                        c('Ingleside',Inglesidetable_title12,Inglesidetable_thisyear12),
                        c('Mission',Missiontable_title1,Missiontable_thisyear1),
                        c('Mission',Missiontable_title2,Missiontable_thisyear2),
                        c('Mission',Missiontable_title3,Missiontable_thisyear3),
                        c('Mission',Missiontable_title4,Missiontable_thisyear4),
                        c('Mission',Missiontable_title5,Missiontable_thisyear5),
                        c('Mission',Missiontable_title6,Missiontable_thisyear6),
                        c('Mission',Missiontable_title7,Missiontable_thisyear7),
                        c('Mission',Missiontable_title8,Missiontable_thisyear8),
                        c('Mission',Missiontable_title9,Missiontable_thisyear9),
                        c('Mission',Missiontable_title10,Missiontable_thisyear10),
                        c('Mission',Missiontable_title11,Missiontable_thisyear11),
                        c('Mission',Missiontable_title12,Missiontable_thisyear12),
                        c('Northern',Northerntable_title1,Northerntable_thisyear1),
                        c('Northern',Northerntable_title2,Northerntable_thisyear2),
                        c('Northern',Northerntable_title3,Northerntable_thisyear3),
                        c('Northern',Northerntable_title4,Northerntable_thisyear4),
                        c('Northern',Northerntable_title5,Northerntable_thisyear5),
                        c('Northern',Northerntable_title6,Northerntable_thisyear6),
                        c('Northern',Northerntable_title7,Northerntable_thisyear7),
                        c('Northern',Northerntable_title8,Northerntable_thisyear8),
                        c('Northern',Northerntable_title9,Northerntable_thisyear9),
                        c('Northern',Northerntable_title10,Northerntable_thisyear10),
                        c('Northern',Northerntable_title11,Northerntable_thisyear11),
                        c('Northern',Northerntable_title12,Northerntable_thisyear12),
                        c('Park',Parktable_title1,Parktable_thisyear1),
                        c('Park',Parktable_title2,Parktable_thisyear2),
                        c('Park',Parktable_title3,Parktable_thisyear3),
                        c('Park',Parktable_title4,Parktable_thisyear4),
                        c('Park',Parktable_title5,Parktable_thisyear5),
                        c('Park',Parktable_title6,Parktable_thisyear6),
                        c('Park',Parktable_title7,Parktable_thisyear7),
                        c('Park',Parktable_title8,Parktable_thisyear8),
                        c('Park',Parktable_title9,Parktable_thisyear9),
                        c('Park',Parktable_title10,Parktable_thisyear10),
                        c('Park',Parktable_title11,Parktable_thisyear11),
                        c('Park',Parktable_title12,Parktable_thisyear12),
                        c('Richmond',Richmondtable_title1,Richmondtable_thisyear1),
                        c('Richmond',Richmondtable_title2,Richmondtable_thisyear2),
                        c('Richmond',Richmondtable_title3,Richmondtable_thisyear3),
                        c('Richmond',Richmondtable_title4,Richmondtable_thisyear4),
                        c('Richmond',Richmondtable_title5,Richmondtable_thisyear5),
                        c('Richmond',Richmondtable_title6,Richmondtable_thisyear6),
                        c('Richmond',Richmondtable_title7,Richmondtable_thisyear7),
                        c('Richmond',Richmondtable_title8,Richmondtable_thisyear8),
                        c('Richmond',Richmondtable_title9,Richmondtable_thisyear9),
                        c('Richmond',Richmondtable_title10,Richmondtable_thisyear10),
                        c('Richmond',Richmondtable_title11,Richmondtable_thisyear11),
                        c('Richmond',Richmondtable_title12,Richmondtable_thisyear12),
                        c('Southern',Southerntable_title1,Southerntable_thisyear1),
                        c('Southern',Southerntable_title2,Southerntable_thisyear2),
                        c('Southern',Southerntable_title3,Southerntable_thisyear3),
                        c('Southern',Southerntable_title4,Southerntable_thisyear4),
                        c('Southern',Southerntable_title5,Southerntable_thisyear5),
                        c('Southern',Southerntable_title6,Southerntable_thisyear6),
                        c('Southern',Southerntable_title7,Southerntable_thisyear7),
                        c('Southern',Southerntable_title8,Southerntable_thisyear8),
                        c('Southern',Southerntable_title9,Southerntable_thisyear9),
                        c('Southern',Southerntable_title10,Southerntable_thisyear10),
                        c('Southern',Southerntable_title11,Southerntable_thisyear11),
                        c('Southern',Southerntable_title12,Southerntable_thisyear12),
                        c('Taraval',Taravaltable_title1,Taravaltable_thisyear1),
                        c('Taraval',Taravaltable_title2,Taravaltable_thisyear2),
                        c('Taraval',Taravaltable_title3,Taravaltable_thisyear3),
                        c('Taraval',Taravaltable_title4,Taravaltable_thisyear4),
                        c('Taraval',Taravaltable_title5,Taravaltable_thisyear5),
                        c('Taraval',Taravaltable_title6,Taravaltable_thisyear6),
                        c('Taraval',Taravaltable_title7,Taravaltable_thisyear7),
                        c('Taraval',Taravaltable_title8,Taravaltable_thisyear8),
                        c('Taraval',Taravaltable_title9,Taravaltable_thisyear9),
                        c('Taraval',Taravaltable_title10,Taravaltable_thisyear10),
                        c('Taraval',Taravaltable_title11,Taravaltable_thisyear11),
                        c('Taraval',Taravaltable_title12,Taravaltable_thisyear12),
                        c('Tenderloin',Tenderlointable_title1,Tenderlointable_thisyear1),
                        c('Tenderloin',Tenderlointable_title2,Tenderlointable_thisyear2),
                        c('Tenderloin',Tenderlointable_title3,Tenderlointable_thisyear3),
                        c('Tenderloin',Tenderlointable_title4,Tenderlointable_thisyear4),
                        c('Tenderloin',Tenderlointable_title5,Tenderlointable_thisyear5),
                        c('Tenderloin',Tenderlointable_title6,Tenderlointable_thisyear6),
                        c('Tenderloin',Tenderlointable_title7,Tenderlointable_thisyear7),
                        c('Tenderloin',Tenderlointable_title8,Tenderlointable_thisyear8),
                        c('Tenderloin',Tenderlointable_title9,Tenderlointable_thisyear9),
                        c('Tenderloin',Tenderlointable_title10,Tenderlointable_thisyear10),
                        c('Tenderloin',Tenderlointable_title11,Tenderlointable_thisyear11),
                        c('Tenderloin',Tenderlointable_title12,Tenderlointable_thisyear12)
)

# clean up the date we captured during scrape
SFtable_update <- mdy(SFtable_update)

# assemble a data frame from the above parts
sf_crime <- as.data.frame(sf_scraped_list)
sf_crime <- t(sf_crime)
sf_crime <- data.frame(sf_crime)
rownames(sf_crime)<-NULL
names(sf_crime) <- c("district","category","last12mos_add")

sf_crime <- sf_crime %>% filter(category!="Crime" & !is.na(category))

sf_crime$last12mos_add <- gsub(",","",sf_crime$last12mos_add)

sf_crime$last12mos_add <- as.numeric(sf_crime$last12mos_add)

sf_crime$category <- gsub("THEFT"," THEFT",sf_crime$category)
sf_crime$category <- gsub("VEHICLE"," VEHICLE",sf_crime$category)
sf_crime$category <- gsub("HUMAN","HUMAN ",sf_crime$category)
sf_crime$category <- gsub("TRAFFICKING-","TRAFFICKING -",sf_crime$category)

sf_crime <- sf_crime %>% mutate_all(na_if,"")
sf_crime <- sf_crime %>% filter(!(is.na(sf_crime$category) & is.na(sf_crime$last12mos_add)))

# we need these unique lists for making the beat tables below
# this ensures that we get crime details for beats even with zero
# incidents of certain types over the entirety of the time period
list_district_type <- crossing(district = unique(sf_crime$district), category = unique(sf_crime$category))
# merging with full list so we have data for every district, every type
sf_crime <- left_join(list_district_type,sf_crime,by=c("district"="district","category"="category"))
# now we replace the remaining NAs with zeros for district/crime combos with no incidents
sf_crime[is.na(sf_crime)] <- 0
# add the update date to the table
sf_crime$lastdate <- SFtable_update
sf_crime_last12mos_add <- sf_crime

# save an archive of most recent weekly file
saveRDS(sf_crime,"scripts/rds/sf_crime_last12mos_add.rds")

# file remove for all of the saved images
# do.call(file.remove, list(list.files("data/source/images/", full.names = TRUE)))

# just for testing/checking; should get an 11 districts and 10 crime categories
# sf_crime_list <- sf_crime %>% group_by(crime) %>% summarise(count=n())
# sf_district_list <- sf_crime %>% group_by(district) %>% summarise(count=n())
