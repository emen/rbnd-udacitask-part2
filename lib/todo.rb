class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  PRIORITIES = %w(high medium low)

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    if @priority && !PRIORITIES.include?(@priority)
      raise UdaciListErrors::InvalidPriorityValue
    end
  end
  def details
    format_description(description) + "due: " +
    format_due_date(due) +
    format_priority(priority)
  end
end
