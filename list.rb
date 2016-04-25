require 'chronic'
require 'colorize'
require 'date'
require 'pp'
require 'highline'
require_relative 'lib/listable'
require_relative 'lib/errors'
require_relative 'lib/event'
require_relative 'lib/link'
require_relative 'lib/todo'
require_relative 'lib/udacilist'

# load the list
list_file = 'data/todo.dat'
the_list  = nil
File.open(list_file) do |fh|
  the_list = Marshal.load(fh) rescue UdaciList.new
end

# menu
cli = HighLine.new

# action dispatch
actions = {
  'add'    => -> { the_list.add(cli.ask('Type? '), cli.ask('Description? ')) },
  'delete' => -> { the_list.delete(cli.ask('Index? ', Integer)) },
  'list'   => -> { the_list.all },
  'filter' => -> { the_list.filter(cli.ask('Filter? '))},
  'exit'   => -> { exit },
  'title'  => -> { the_list.title = cli.ask('New title? ') },
  'save'   => -> { File.open(list_file, 'w') {|fh| Marshal.dump(the_list, fh)} },
  'others' => -> { puts 'Invalid action'.red }
}

actions_prompt = 'Actions [list|add|delete|filter|title|save|exit]? '
while true
  action = cli.ask(actions_prompt)
  (actions[action] || actions['others']).call
end

