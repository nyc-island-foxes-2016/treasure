module ApplicationHelper
  def std_format_date date
    return "" unless date
    date.strftime("%b %e, %Y at %l:%M %P")
  end
end
