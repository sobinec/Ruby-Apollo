require 'colorize'

module LogBox
  def self.log(message)
    puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}" + " [LOG]".colorize(:blue) + " #{message}"
  end
    def self.warn(message)
    puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}" + " [WARN]".colorize(:yellow) + " #{message}"
  end

  def self.done(message)
    puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}" + " [DONE]".colorize(:green) + " #{message}"
  end

  def self.error(message)
    puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}" + " [ERROR]".colorize(:red) + " #{message}"
  end

  def self.critical(message)
    puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}" + " [CRITICAL]".colorize(:light_red) + " #{message}"
  end

end