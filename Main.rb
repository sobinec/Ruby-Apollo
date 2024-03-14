require "discordrb"
require "json"

# Load dependencies
Dir["./ToolBox/*.rb"].each { |file| require_relative file }
Dir["./Cogs/*.rb"].each { |file| require_relative file }

token = File.read("./Token.secret")

bot = Discordrb::Commands::CommandBot.new(token: token, prefix: "?")

bot.ready do |event|
  LogBox.done "The bot is ready!"
end

bot.message do |event|
  server = event.server
  member = server.member(event.user)
  msg = event.content
  user_id = event.author.id

  # Check if the message content is a greeting
  if ["hi", "hello"].include?(msg.lowercase)
    embed = EmbedTools.embed("Hello, #{member.name}!", "I'm glad to see you there, #{member.name}!")
    embed = EmbedTools.random_footer(embed)
    event.channel.send_embed("", embed)
  end
end

# Start the bot
bot.run