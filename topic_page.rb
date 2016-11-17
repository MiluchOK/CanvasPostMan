class TopicPage
  def initialize(driver)
    @driver = driver
  end

  def reply(message)
    @driver.find_element(css: 'a.discussion-reply-box').click
    sleep(2)
    frame = @driver.find_element(css: 'div.mce-tinymce iframe')
    # @driver.switch_to.frame(frame)
    frame.send_keys message
    sleep(2)
    #@driver.switch_to.default_content
    @driver.find_elements(css: 'div.show-if-replying form div.discussion-reply-buttons button')[0].click
  end
end