module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Spending-Note'
    if page_title.empty?
      base_title
    else
      page_title = page_title + ' - ' + base_title
    end
  end
end
