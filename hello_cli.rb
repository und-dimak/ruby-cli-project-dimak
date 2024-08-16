# frozen_string_literal: true
require 'thor'

class HelloCLI < Thor
  class_option :verbose, :type => :boolean

  desc "hello NAME", "say hello to NAME"
  long_desc <<-LONGDESC
 `cli hello` will print out a message to a person of your choosing.\x5

    > $ ruby hello_cli.rb hello "Dima" --from "Sasha"\x5
    > from: Sasha
  LONGDESC

  option :yell, :type => :boolean, desc: "Optional parameter, which will print the output in all caps."
  option :from, :type => :string, desc: "Optional parameter, which will print out a 'from' message as well."

  def hello(name)
    puts "> saying hello" if options[:verbose]
    output = []
    output << "from: #{options[:from]}" if options[:from]
    output << "Hello #{name}"
    output = output.join("\n")
    puts options[:yell] ? output.upcase : output
  end

  desc "goodbye", "say goodbye to the world"

  def goodbye
    puts "> saying goodbye" if options[:verbose]
    puts "Goodbye World"
    puts "> done saying goodbye" if options[:verbose]
  end

end

HelloCLI.start(ARGV)