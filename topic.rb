class Topic
  def initialize(web_element)
    @self_web = web_element
    @name = @self_web.find_element(css: 'a').text
  end

  def go_to
    @self_web.find_element(css: 'a').click
  end

  def get_name
    @name
  end
end