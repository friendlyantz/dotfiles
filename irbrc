begin
  require 'rubygems'
  require 'pry'
  require "awesome_print" 
  AwesomePrint.irb!
rescue LoadError
end

# if defined?(Pry)
#   Pry.start
#   exit
# end
