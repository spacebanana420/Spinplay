def generateconfig()
    configuration="volume=12\nsafecheck=true\nfullscreen=false\npathsperline=3\nlinesperblock=10\nlinespacing=5"
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
            when "pathsperline"
                paths_line = getvaluefromoption(line)
                if checkifnumber(paths_line) == true
                    if paths_line == "0"
                        $pathsperline = 1
                    else
                        $pathsperline = paths_line.to_i
                    end
                end
            when "linesperblock"
                blocksize = getvaluefromoption(line)
                if checkifnumber(blocksize) == true
                    $linesperblock = blocksize.to_i
                end
            when "linespacing"
                spacing = getvaluefromoption(line)
                if checkifnumber(spacing) == true
                    spacing = spacing.to_i
                    $linespacing = ""
                    spacing.times do
                        $linespacing += " "
                    end
                end
            end
        end
    end
    return true
end

def getvaluefromoption(line)
    line = line.sub("\n", "")
    chars = line.chars
    startreading = false
    value = ""

    chars.each do |char|
        if startreading == true
            value += char
        end

        if char == "="
            startreading = true
        end
    end
    return value
end

def whichoption(line)
    if line.chars[0] == "#"
        return false
    end
    options = ["volume", "safecheck", "fullscreen", "pathsperline", "linesperblock", "linespacing"]
    options.each do |option|
        if line.include?(option) == true
            return option
        end
    end
    return false
end
