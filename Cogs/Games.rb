require 'discordrb'
Dir["../ToolBox/*.rb"].each { |file| require_relative file }

module Games
  extend Discordrb::Commands::CommandContainer

  command(:slots, description: 'Play slots!', usage: '?slots') do |event|
    # Define the symbols for the slots game
    slot_emojis = ["🧇", "🫐", "🥝", "🥚", "🥞", "🍧", "🧋", "🍨", "🍣", "🍌", "🍕", "🧀"]

    # Generate the slots
    slots = Array.new(4) { Array.new(4) { slot_emojis.sample } }.map { |row| row.join("  |  ") }

    # Check for a win
    result = slots.any? { |row| row.split("  |  ").uniq.size == 1 }

    # Prepare the embed message
    embed = Discordrb::Webhooks::Embed.new(
      title: "Casino",
      color: 16108365,
      fields: [{ name: result ? "YOU WIN!\n" : "YOU LOST!\n", value: slots.join("\n"), inline: false }]
    )

    # Send the embed message
    event.channel.send_embed("", embed)
  end

  command(:rps, description: 'Play rock paper scissors!', usage: '?rps') do |event|
    rps_array = ["🧻", "🪨", "✂️"]
   
    user_choice_parts = event.message.content.split(' ')
    if user_choice_parts.size < 2
       event.respond "Usage: *?rps rock/paper/scissors*"
       next
    end
   
    user_choice = user_choice_parts[1].downcase
   
    unless ["rock", "paper", "scissors"].include?(user_choice)
       event.respond "Invalid choice. Please choose rock, paper, or scissors."
       next
    end

    # Transforming user input into emojis
   
    user_choice_emoji = case user_choice
                         when "rock"
                           "🪨"
                         when "paper"
                           "🧻"
                         when "scissors"
                           "✂️"
                         end
   
    bot_choice_emoji = rps_array.sample
   
    embed = Discordrb::Webhooks::Embed.new(
       title: "Rock Paper Scissors",
       description: "Let's see who wins!",
       color: 0x00ff00 # Green color for embed
    )

    # Checking if the user won or not
   
    if user_choice_emoji == bot_choice_emoji
       embed.add_field(name: "Result", value: "It's a tie! Both chose #{user_choice_emoji}.", inline: false)
    elsif (user_choice_emoji == "🪨" && bot_choice_emoji == "✂️") ||
           (user_choice_emoji == "🧻" && bot_choice_emoji == "🪨") ||
           (user_choice_emoji == "✂️" && bot_choice_emoji == "🧻")
       embed.add_field(name: "Result", value: "You win! #{user_choice_emoji} beats #{bot_choice_emoji}.", inline: false)
    else
       embed.add_field(name: "Result", value: "You lose! #{bot_choice_emoji} beats #{user_choice_emoji}.", inline: false)
    end
   
    event.channel.send_embed("", embed)
   end
end
