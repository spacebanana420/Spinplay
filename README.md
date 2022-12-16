# SpinPlay
SpinPlay is a Bash frontend that uses FFplay for more extensive and convenient media playback from the CLI.

SpinPlay adds more features to FFplay and makes it more usable on a daily-basis, which quality-of-life features such as setting the volume automatically when undefined and using autostop by default

# Features
* Main menu to choose files and navigate through directories
* Full FFplay feature integration
* FFmpeg's extremely wide format support
* Config for defaults
* Favorite folders
* Mixing defined arguments with config defaults
* Convenience for regular use by falling back some arguments to predefined values
* Extra player features, such as playing all files in current directory
* File seeking
* Fast and lightweight

# Requirements and supported systems
SpinPlay works on all systems capable of using FFmpeg and Bash, and systems whose core utilities have the "echo", "ls" "cd" utilities.

In a nutshell, SpinPlay works on nearly all Linux-based systems, BSD systems, MacOS and even Windows with some configurations

Eventually, a second version of SpinPlay will be written in Powershell for Windows users to natively use the utility without having to install Bash.

### Officially supported systems:
* Debian Linux and derivatives (Ubuntu, etc)
* Arch Linux and derivatives (Manjaro, EndeavourOS, etc)
* Fedora Linux
* OpenSUSE
* Alpine Linux
* MacOS
* Void Linux
* FreeBSD

### Requirements
* Bash
* FFmpeg

### Installing dependencies
Debian ``` apt install bash ffmpeg ```

Arch Linux ``` pacman -S bash ffmpeg ```

Fedora Linux ``` dnf install bash ffmpeg ```
