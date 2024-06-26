#!/usr/bin/env ruby

# 1. copy this script to ~/iterm_command_click
# 2. edit IDE_LIFESTYLE below (and DEBUG too if you like)
# 3. iTerm2 preferences:
# Profiles > Advanced > "Semantic History"
# Choose "Always run command..."
# Enter: ~/iterm_command_click "\1" "\2" "\5"

# For rubymine, see https://www.jetbrains.com/help/ruby/working-with-the-ide-features-from-command-line.html#launchers-macos-linux
# install to /usr/local/bin/mine (or edit the command below if you choose a different location)

# For vscode, run this:
# ln -s " /Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" /usr/local/bin/code

# For sublime text, run this:
# ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

filename = ARGV.shift
linenumber = ARGV.shift
workingdir = ARGV.shift

IDE_LIFESTYLE = 'code'.freeze
DEBUG = true

module Debug
  HOME = File.expand_path('~').freeze
  DEBUG_PATH = "#{HOME}/launches.log".freeze

  def self.log(message)
    return unless DEBUG

    File.open(DEBUG_PATH, 'a') do |file|
      file.puts message
    end
  end
end

Debug.log("launching filename #{filename} in #{workingdir} with line number #{linenumber}")

# editor launching
module Launcher
  def self.open(path, number)
    log_launch(path, number)
    case IDE_LIFESTYLE
    when 'atom'
      open_default('/usr/local/bin/atom', path, number)
    when 'code'
      open_code(path, number)
    when 'emacs'
      open_emacs(path, number)
    when 'mate'
      open_default('/usr/local/bin/mate', path, number)
    when 'mine'
      open_rubymine(path, number)
    when 'subl'
      open_default('/usr/local/bin/subl', path, number)
    when 'xi'
      open_default('/usr/local/bin/xi', path, number)
    end
  end

  def self.log_launch(path, number)
    if number.empty?
      Debug.log("Launching #{path}")
    else
      Debug.log("Launching #{path} on line #{number}")
    end
  end

  def self.open_default(bin, path, number)
    if number.empty?
      system "'#{bin}' #{path}"
    else
      system "'#{bin}' #{path}:#{number}"
    end
  end

  def self.open_code(path, number)
    if number.empty?
      system "/usr/local/bin/code -g #{path}"
    else
      system "/usr/local/bin/code -g #{path}:#{number}"
    end
  end

  def self.open_emacs(path, number)
    if number.empty?
      system "/opt/homebrew/bin/emacsclient -n #{path}"
    else
      system "/opt/homebrew/bin/emacsclient -n +#{number} #{path}"
    end
  end

  def self.open_rubymine(path, number)
    if number.empty?
      system "/usr/local/bin/mine #{path}"
    else
      system "/usr/local/bin/mine --line #{number} #{path}"
    end
  end
end

Debug.log("filename=#{filename}")
Debug.log("linenumber=#{linenumber}")
Debug.log("workingdir=#{workingdir}")

if filename.start_with?("http://")
  system "open #{filename}"
  exit
end

if filename.start_with?("https://")
  system "open #{filename}"
  exit
end

filename_sections = filename.split(':')

if filename_sections.length > 1
  filename = filename_sections[0]
  linenumber = filename_sections[1]
end

launchpath = case filename
             when %r{^/}
               filename
             when /^~/
               filename
             else
               "#{workingdir}/#{filename}"
             end

Launcher.open(launchpath, linenumber)

Debug.log('--------------------')

