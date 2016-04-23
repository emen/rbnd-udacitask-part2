require 'colorize'
module Listable

  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_date_range(start_date = nil, end_date = nil)
    dates = start_date.strftime("%D") if start_date
    dates << " -- " + end_date.strftime("%D") if end_date
    dates = "N/A" if !dates
    return dates
  end

  def format_name(site_name = nil)
    site_name ? site_name : ""
  end

  def format_due_date(due = nil)
    due ? due.strftime("%D") : "No due date"
  end

  def format_priority(priority = nil)
    value = " ⇧".red if priority == "high"
    value = " ⇨".blue if priority == "medium"
    value = " ⇩".light_blue if priority == "low"
    value = "" if !priority
    return value
  end

end
