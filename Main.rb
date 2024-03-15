require "discordrb"
require "json"

# Load tools
Dir["./ToolBox/*.rb"].each { |file| require_relative file }

token = File.read("./Token.secret")

# Creating the main bot variable
bot = Discordrb::Commands::CommandBot.new(token: token, prefix: "?")

# Load and log each cog from the Cogs directory that ends with .rb
Dir["./Cogs/*.rb"].each do |file|
  require_relative file
  cog_name = File.basename(file, ".rb").capitalize
  bot.include! eval(cog_name)
  LogBox.done "Loaded cog: #{cog_name}"
end

bot.ready do |event|
  LogBox.done "The bot is ready!"
end

bot.message do |event|
  server = event.server
  member = server.member(event.user)
  msg = event.content
  user_id = event.author.id

  # Check if the message content is a greeting
  if ["hi", "hello"].include?(msg.downcase)
    embed = EmbedTools.embed("Hello, #{member.name}!", "I'm glad to see you there, #{member.name}!")
    embed = EmbedTools.random_footer(embed)
    event.channel.send_embed("", embed)
  end
end

# Start the bot
bot.run
