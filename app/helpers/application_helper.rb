module ApplicationHelper

  def full_title(page_title)
    base_title = "benfeitoria"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def icon_tag(name)
    content_tag :i, nil, class: "icon-#{name}"
  end

  def icon_link_to(icon, target, *args)
    link_to "#{icon_tag icon}".html_safe, target, *args
  end
  
end
