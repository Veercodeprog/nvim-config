# Neovim Configuration - Settings and Shortcuts

**This repository contains my custom Neovim (nvim) configuration implemented in Lua. It includes a collection of settings, design changes, and shortcuts to enhance your Neovim experience.**

## Installation

To use this Neovim configuration, follow these steps:

1. **Backup Your Current Neovim Configuration:** If you have an existing Neovim configuration, back it up by renaming your `~/.config/nvim` directory to something else like `~/.config/nvim_backup`.

2. **Clone This Repository:** Clone this repository into your `~/.config` directory, which is where Neovim looks for its configuration files.

    ```bash
    git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
    ```

3. **Open Neovim:** Launch Neovim by simply running `nvim` in your terminal.

4. **Customize Configuration (Optional):** Feel free to modify the configuration to suit your needs. You can edit the `~/.config/nvim/init.lua` file to tweak settings, add plugins, or adjust key bindings.

5. **Restart Neovim:** After making any changes to your configuration, restart Neovim to apply them.

## Configuration Highlights

Here are some of the key aspects of this Neovim configuration:

### 1. Plugins

This configuration utilizes several plugins to enhance functionality, including:

- **[Plugin Name](https://link.to/plugin/docs):** A brief description of the plugin and why it's included.

    ```lua
    -- Example configuration for the plugin
    use 'username/plugin-name'
    ```

- **[Another Plugin](https://link.to/another/plugin/docs):** Another description.

    ```lua
    -- Example configuration for another plugin
    use 'username/another-plugin'
    ```

### 2. Shortcuts

Custom shortcuts have been defined to streamline common tasks:

- **General Shortcuts:**

    - `<leader> + w`: Save the current file.
    - `<leader> + q`: Quit Neovim.
    - `<leader> + r`: Reload Neovim configuration.

- **File Navigation:**

    - `<leader> + f`: Open a file explorer (NERDTree).
    - `<leader> + t`: Open a new tab.
    - `<leader> + [1-9]`: Switch between tabs.

- **Code Editing:**

    - `<leader> + e`: Toggle NERDCommenter for commenting/uncommenting code.
    - `<leader> + s`: Save the current buffer.
    - `<leader> + n`: Toggle line numbers.

- **Plugin-Specific Shortcuts:**

    - `<shortcut>`: Description of the shortcut.

Please refer to the `~/.config/nvim/init.lua` file for a complete list of custom shortcuts and their descriptions.

### 3. Themes and Design Changes

The configuration includes a custom theme and design changes to improve the visual appeal of Neovim. The theme used is [Theme Name](https://link.to/theme/docs), which provides a pleasing coding environment.

### 4. Additional Settings

Various Neovim settings have been adjusted and customized for a smoother editing experience. These settings can be found in the `~/.config/nvim/init.lua` file.

## Troubleshooting

If you encounter any issues or have questions about this Neovim configuration, feel free to [open an issue](https://github.com/yourusername/nvim-config/issues) on the repository.

## License

**This Neovim configuration is distributed under the MIT License. See [LICENSE](LICENSE) for more information.**

