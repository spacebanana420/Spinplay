def spawn(msg)
    puts msg
    return gets.chomp
end

def printClear(msg)
    print("\u001B[H\u001B[2J#{msg}")
end

def spawnClear(msg)
    print("\u001B[H\u001B[2J#{msg}")
    return gets.chomp
end

def foreground(color)
    case color
        when "black"
            return "\u001B[30m"
        when "red"
            return "\u001B[31m"
        when "green"
            return "\u001B[32m"
        when "yellow"
            return "\u001B[33m"
        when "blue"
            return "\u001B[34m"
        when "magenta"
            return "\u001B[35m"
        when "cyan"
            return "\u001B[36m"
        when "white"
            return "\u001B[37m"
        when "default"
            return "\u001B[39m"
        when "reset"
            return"\u001B[0m"
        else
            return "\u001B[39m"
    end
end

def background(color)
    case color
        when "black"
            return "\u001B[40m"
        when "red"
            return "\u001B[41m"
        when "green"
            return "\u001B[42m"
        when "yellow"
            return "\u001B[43m"
        when "blue"
            return "\u001B[44m"
        when "magenta"
            return "\u001B[45m"
        when "cyan"
            return "\u001B[46m"
        when "white"
            return "\u001B[47m"
        when "default"
            return "\u001B[49m"
        when "reset"
            return "\u001B[0m"
        else
            "\u001B[49m"
    end
end

# def clear_terminal()
#     if $platform == 0
#         system("clear")
#     else
#         system("cls")
#     end
# end

def clear_terminal()
    print("\u001B[H\u001B[2J")
end
