class UdaciList

  attr_reader   :items
  attr_accessor :title

  def initialize(options={})
    @title = options[:title] || 'Untitled'
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    case type
    when 'todo' then @items.push TodoItem.new(description, options)
    when 'event'then @items.push EventItem.new(description, options)
    when 'link' then @items.push LinkItem.new(description, options)
    else
      raise UdaciListErrors::InvalidItemType,
        "Invalid item type '#{type}'. type = todo | event | link"
    end
  end
  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize if index > items.length
    @items.delete_at(index - 1)
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  def filter(type)
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}" if item.class.name.downcase == type + 'item'
    end
  end
end
