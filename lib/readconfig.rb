def generateconfig()
    configuration="volume=12\nsafecheck=true\nfullscreen=false"
    File.write("#{$startingdir}/config.txt", configuration)
end

def readconfig()
    if File.file?("#{$startingdir}/config.txt") == false
        generateconfig()
        return
    end
    config_lines = File.readlines("#{$startingdir}/config.txt")
    config_lines.each do |line|
        option = whichoption(line)
        if option != false
            case option
            when "volume"
                $volume = "-volume #{getvaluefromoption(line)}"
            when "safecheck"
                if getvaluefromoption(line) == "false"
                    $safecheck = false
                else
                    $safecheck = true
                end
            when "fullscreen"
                if getvaluefromoption(line) == "true"
                    $fullscreen = true
                else
                    $fullscreen = false
                end
            end
        end
    end
    return true
end

def getvaluefromoption(line)
    line = line.sub("\n")
    chars = line.chars
    startreading = false
    value = ""

    chars.each do |char|
        if char == "="
            startreading = true
        end
        if startreading == true
            value += char
        end
    end
    return value
end

def whichoption(line)
    if line.chars[0] == "#"
        return false
    end
    options = ["volume", "safecheck", "fullscreen"]
    options.each do |option|
        if line.include?(option) == true
            return option
        end
    end
    return false
end
