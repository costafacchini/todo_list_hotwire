# Peny Coding Challenge

Please build your own implementation of a task list full-stack web application following these guidelines (please note that this app is not related to our platform, but rather, a way for us to understand your approach to coding).

## Requirements

1. View a list of to-do items with the ability to filter the list by pending, complete, and all to-dos
2. Create a new to-do item
3. Edit a to-do item
4. Delete a to-do item
5. Complete a to-do item
6. Sending the deployed application

## Setup Ruby (only if you have not installed)

This project uses [asdf](https://asdf-vm.com/guide/getting-started.html). \
Follow the installation [instructions](https://asdf-vm.com/guide/getting-started.html#_3-install-asdf)

After installation you need to follow these steps:

```bash
# Add ruby plugin on asdf
$ asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

# Install ruby plugin
$ asdf install ruby 3.3.1
```

## Setup Project

```bash
# install bundler
$ gem install bundler

# setup project
$ bin/setup
```

## Available Tasks

```bash
# run the project in development mode
$ bin/dev

# run linter (backend)
$ bin/rubocop
```
