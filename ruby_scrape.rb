require 'selenium-webdriver'
require 'nokogiri'
require 'open-uri'
require 'csv'



browser = Selenium::WebDriver.for :chrome
browser.get "https://www.amazon.com"
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
input = wait.until {
element = browser.find_element(:id, "twotabsearchtextbox")
element if element.displayed?
}
input.send_keys("iphone")

click_input = wait.until {
    element = browser.find_element(:class, "nav-input")
    element if element.displayed?
}
click_input.click
doc = Nokogiri::HTML(browser.page_source)
CSV.open("file.csv", "wb") do |csv|
  doc.css('a.a-link-normal').each do |row|
	title = row.css('h2').inner_text
	csv << [title]
  end
end