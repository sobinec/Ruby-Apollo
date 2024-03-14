# README.md for Ruby Apollo Discord Bot

## Introduction

Welcome to the Discord bot project! This bot is designed to be self-hosted and used exclusively within a single server. It's built with Ruby, leveraging the `discordrb` library for Discord bot functionality and `colorize` for enhanced logging. The bot is modular, allowing you to enable or disable specific functionalities by renaming files in the `Cogs` directory (Add .disabled to the end of the plugins you don't want to use). This README will guide you through the setup process and provide an overview of the project's structure and guidelines.

## Prerequisites

- Ruby installed on your system.
- A Discord bot token.

## Setup

1. **Place your Discord bot token**: Create a file named `Token.secret` in the root directory of the project and paste your Discord bot token inside it.

2. **Install dependencies**: Run `bundle install` in the terminal from the project's root directory to install all necessary Ruby gems.

3. **Launch the bot**: Execute `ruby main.rb` to start the bot.

## Modularity and Customization

The bot is designed to be modular, allowing you to enable or disable specific functionalities by renaming files in the `Cogs` directory. To disable a functionality, simply add `.disabled` to the end of the file name, except for the functionalities you wish to keep enabled. For example, if you only need moderation functionalities, you would rename all other files in the `Cogs` directory to have the `.disabled` extension, leaving only the moderation files without this extension.

## Writing Plugins

You can write your own plugins and place them in the `Cogs` folder. They will be automatically added to the bot's functionality. Ensure that your plugin files follow the naming conventions outlined below.

## Naming Conventions

- **Folders**: Use capital letters without spaces or any symbols like `-`, `_`, or `,`. Example: `CoolFolderName`.
- **Files**: Follow the same naming convention as folders. Example: `CoolFileName`.

## Logging

For logging purposes, use the `LogBox` module. This ensures consistency across the project's logging mechanism.

## Contributing

If you wish to contribute to this project, please adhere to the following rules:

- Follow the naming conventions for folders and files.
- Use the `LogBox` module for logging.

## License

This project is licensed under the MIT License.

## Credits

- [discordrb](https://github.com/discordrb/discordrb) for the Discord bot library.
- [colorize](https://github.com/fazibear/colorize) for colorful logging.

## Support

For any questions or support, please contact me [https://sobinec.vercel.app/contact.html](https://sobinec.vercel.app/contact.html).
