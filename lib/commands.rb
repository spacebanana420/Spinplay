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
    puts "Spinplay v1.0 help menu\n
Spinplay is a front-end for FFplay which adds a file browser and automates a lot of the boring stuff you need to type to use FFplay as a proper media player

Common controls during playback:
    - Space: pause
    - Esc or Q: stop
    - 9: Decrease volume
    - 0: Increase volume

List of commands:
    - help
    - volume

Press any key to exit"
    gets; clear_terminal
end

def choose_volume()
    clear_terminal()
    puts "Current volume percentage: #{$volume}%\nChoose a volume percentage between 0 and 100"
    answer = gets.chomp
    100.times do |i|
        if i.to_s == answer
            $volume = "-volume #{answer}"
        end
    end
    clear_terminal()
end
