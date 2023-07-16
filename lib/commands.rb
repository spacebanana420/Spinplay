def read_command(answer)
    case answer
    when "help"
        printhelp()
        return true
    when "volume"
        choose_volume()
        return true
    else
        return false
    end
end

def printhelp()
    clear_terminal()
    puts "Spinplay v1.1 help menu\n
Spinplay is a front-end for FFplay which adds a file browser and automates a lot of the boring stuff you need to type to use FFplay as a proper media player

Common controls during playback:
    - Space: pause
    - Esc or Q: end playback
    - 9: decrease volume
    - 0: increase volume
    - Arrow keys: move in timeline
    - W: switch to waveform display
    - M: mute audio

List of commands:
    - help
    - volume

Press any key to exit"
    gets; clear_terminal
end

def choose_volume()
    clear_terminal()
    puts "Current volume setting: #{$volume}\nChoose a volume value between 0 and 100"
    answer = gets.chomp
    100.times do |i|
        if i.to_s == answer
            $volume = "-volume #{answer}"
        end
    end
    clear_terminal()
end
