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
    else
        return false
    end
end

def printhelp()
    clear_terminal()
    puts "Spinplay v1.1 help menu\n
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
    - volume

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
