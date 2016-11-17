class ProjectCard
  def initialize(element)
    @self_element = element
    @name = @self_element.find_element(css: 'a.ic-DashboardCard__link').text
  end

  def get_name
    @name
  end

  def go_to_discussions
    @self_element.find_element(css: 'a.discussions').click
  end
end