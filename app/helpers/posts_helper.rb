module PostsHelper
  def get_category_color(index)
    colors = [
      '#667eea', '#764ba2', '#f093fb', '#4facfe',
      '#00f2fe', '#43e97b', '#fa709a', '#fee140',
      '#a8edea', '#fed6e3'
    ]
    colors[index % colors.length]
  end
end
