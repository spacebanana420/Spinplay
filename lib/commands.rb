def read_command(answer)
    case answer
    when "help"
        printhelp()
        return true
    when "volume"
        choose_volume(false)
        return true
    when "mute"
        $mute = !$mute
        return true
    when "config"
        printconfig()
        return true
    else
        if answer.include?("search ") == true
            find_path(answer.sub("search ", ""))
            return true
        end
    end
    return false
end


def printconfig()
    clear_terminal()
    config_list = "Spinplay config\n\nVolume: #{$volume.sub("-volume ", "")}\n"
    if $safecheck == true
        config_list += "Safecheck: true\n"
    else
        config_list += "Safecheck: false\n"
    end
    if $fullscreen == true
        config_list += "Fullscreen: true\n"
    else
        config_list += "Fullscreen: false\n"
    end
    config_list += "Paths per line: #{$pathsperline}\n"
    config_list += "Lines per block: #{$linesperblock}\n"

    linespacing_number = 0
    $linespacing.chars().each do
        linespacing_number += 1
    end
    config_list += "Line spacing: #{linespacing_number}\n"

    puts "#{config_list}\nPress any key to exit"
    gets
end

def printhelp()
    clear_terminal()
    puts "Spinplay v1.3 help menu\n
Spinplay is a front-end for FFplay which adds a file browser and automates a lot of the boring stuff you need to type to use FFplay as a proper media player

Common controls during video/audio playback:
    - Space or P: pause
    - Esc or Q: end playback
    - S: advance 1 frame
    - F or double mouse click: toggle fullscreen
    - 9: decrease volume
    - 0: increase volume
    - Arrow keys: move in timeline
    - W: switch to waveform display
    - M: mute audio

List of commands:
    - help
    - search [name_to_find]
    - volume
    - mute
    - config

File detection is done through their extensions and it's case-sensitive, so the media files without or with a different extension than the one for their format will not be detected

File Extensions:
    Video
        mp4
        mov
        avi
        m4v
        mkv
        webm
    Image
        png
        jpg
        bmp
        tiff
        tif
        TIF
        heif
        heic
        avif
        webp
        gif
    Audio
        mp3
        wav
        ogg
        opus
        flac
        m4a

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
