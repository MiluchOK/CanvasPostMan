require "selenium-webdriver"
require 'yaml'
require 'pry'
require_relative 'project_card'
require_relative 'topic'
require_relative 'topic_page'

class CanvasPostMan
  def initialize(yaml_file)
    @creds = get_configs(yaml_file)
    @driver = Selenium::WebDriver.for(:phantomjs)
  end

  def post(message)
    login_to_canvas
    get_project_card('F16 Interm Software Design in Java Sections 02W, 02W').go_to_discussions
    sleep(2)
    get_topic('General and Off-Topic').go_to
    sleep(2)
    leave_a_post(message)
    get_screenshot
  end

  def get_configs(yaml)
    YAML.load_file(yaml)
  end

  private
  def login_to_canvas
    @driver.get('https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjmxp-S8K7QAhVnwlQKHWPhBVQQFggdMAA&url=https%3A%2F%2Ffoothillcollege.instructure.com%2F&usg=AFQjCNGmVcAk4wymBO-T6XJ8FCLQEZOEcQ')
    @driver.find_element(css: '#username').send_keys @creds['username']
    @driver.find_element(css: '#password').send_keys @creds['password']
    @driver.find_element(css: 'input[name="submit"]').click
  end

  def get_project_card(name)
    cards = @driver.find_elements(css: 'div.ic-DashboardCard')
    cards.each do |card|
      card_object = ProjectCard.new(card)
      return card_object if card_object.get_name == name
    end
    raise RuntimeError, "No card with name '#{name}' has been found."
  end

  def get_screenshot
    @driver.save_screenshot('/Users/amilyukov/RubymineProjects/CanvasPostMan/lol.png') #TODO For testing
  end

  def leave_a_post(message)
    page = TopicPage.new(@driver)
    page.reply(message)
  end

  def get_topic(name)
    @driver.find_elements(css: 'li.discussion').each do |topic|
      topic = Topic.new(topic)
      return topic if topic.get_name == name
    end
  end
end


CanvasPostMan.new('configs.yaml').post 'zI am being active on the forum!' #Weird bug with the firs char not being typed in