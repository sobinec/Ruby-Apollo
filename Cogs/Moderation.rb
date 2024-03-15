require 'discordrb'
Dir["../ToolBox/*.rb"].each { |file| require_relative file }

module Moderation
  extend Discordrb::Commands::CommandContainer

  command(:ban, description: 'Ban a user from the server.', usage: '?ban <user> [reason]', permission_level: 2) do |event, user, *reason|
    unless user
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "You must specify a user to ban."
      end
      next
    end
  
    # Check if the user is valid
    unless event.server.member(user)
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "The specified user is not valid or does not exist in this server."
      end
      next
    end

    unless event.bot.profile.permission?(:ban_members, event.server)
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "I don't have permission to ban users."
      end
      next
    end

    unless event.user.permission?(:ban_members, event.server)
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "You don't have permission to ban users."
      end
      next
    end

    event.server.ban(user, reason: reason.join(' '))
      event.channel.send_embed do |embed|
        embed.title = "User Banned"
        embed.color = 0x00FF00
        embed.description = "#{user.name} has been banned."
      end
    rescue Discordrb::Errors::NoPermission
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "I don't have permission to ban this user."
      end
    end

  command(:kick, description: 'Kick a user from the server.', usage: '?kick <user> [reason]', permission_level: 2) do |event, user, *reason|
    # Check if a user is provided
    unless user
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "You must specify a user to kick."
      end
      next
    end

    # Check if the user is valid
    unless event.server.member(user)
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "The specified user is not valid or does not exist in this server."
      end
      next
    end

    unless event.bot.profile.permission?(:kick_members, event.server)
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "I don't have permission to kick users."
      end
      next
    end

    unless event.user.permission?(:kick_members, event.server)
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "You don't have permission to kick users."
      end
      next
    end

    event.server.kick(user, reason: reason.join(' '))
      event.channel.send_embed do |embed|
        embed.title = "User Kicked"
        embed.color = 0x00FF00
        embed.description = "#{user.name} has been kicked."
      end
    rescue Discordrb::Errors::NoPermission
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "I don't have permission to kick this user."
      end
    end

  command(:timeout, description: 'Set a timeout for a user.', usage: '?timeout <user> <duration> [reason]', permission_level: 2) do |event, user, duration, *reason|
    # Check if a user is provided
    unless user
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "You must specify a user to timeout."
      end
      next
    end

    # Check if the user is valid
    unless event.server.member(user)
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "The specified user is not valid or does not exist in this server."
      end
      next
    end

    # Check if a duration is provided
    unless duration
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "You must specify a duration for the timeout."
      end
      next
    end

    unless event.bot.profile.permission?(:manage_roles, event.server)
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "I don't have permission to manage roles."
      end
      next
    end
    unless event.user.permission?(:manage_roles, event.server)
      event.channel.send_embed do |embed|
        embed.title = "Error"
        embed.color = 0xFF0000
        embed.description = "You don't have permission to manage roles."
      end
      next
    end
    duration_seconds = duration.to_i * 60

    timeout_role = event.server.roles.find { |role| role.name == "Timeout" }
    unless timeout_role
      timeout_role = event.server.create_role(name: "Timeout")
      event.server.default_channel.define_overwrite(timeout_role, 0, 0, 0, 0, 0, 0)
    end

    user.add_role(timeout_role, reason: reason.join(' '))

    sleep(duration_seconds)
    user.remove_role(timeout_role, reason: "Timeout expired")

    event.channel.send_embed do |embed|
      embed.title = "User Timed Out"
      embed.color = 0x00FF00
      embed.description = "#{user.name} has been timed out for #{duration} minutes."
    end
  end
end
