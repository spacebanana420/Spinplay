$video_formats = [".mp4", ".mov", ".mkv", ".webm", ".avi", ".m4v", ".gif"]
$audio_formats = [".flac", ".mp3", ".m4a", ".wav", ".ogg", ".opus"]
$image_formats = [".png", ".jpg", ".bmp", ".tiff", ".tif", ".TIF", ".avif", ".heic", ".heif", ".webp", ".ppm"]

$volume = "-volume 10"
$mute = false
#$showmode = ""

def playmedia(path)
    args = $volume
    if path.include?(".gif") == true
        args += " -loop 0"
    end
    if is_image(path) == false
        args += " -autoexit"
    end
    if is_audio(path) == true
        args += " -x 400 -y 400"
    end
    if $mute == true
        args += " -an"
    end
    Thread.new {
        system("ffplay -loglevel 16 #{args} \"#{path}\"")
        #testing shit
        #system("ffplay", "-loglevel", "16", "#{$autoexit} #{$volume} #{$showmode} #{$width} #{$height}", path)
        #system("ffplay", "-loglevel", "16", "-autoexit", "-volume", "10", path)
        puts "Finished playing #{path}"
    }
end

def is_video(filename)
    $video_formats.each do |fmt|
        if filename.include?(fmt) == true
            return true
        end
    end
    return false
end

def is_audio(filename)
    $audio_formats.each do |fmt|
        if filename.include?(fmt) == true
            return true
        end
    end
    return false
end

def is_image(filename)
    $image_formats.each do |fmt|
        if filename.include?(fmt) == true
            return true
        end
    end
    return false
end

def check_if_supported(filename)
    $video_formats.each do |fmt|
        if filename.include?(fmt) == true
            return true
        end
    end
    $audio_formats.each do |fmt|
        if filename.include?(fmt) == true
            return true
        end
    end
    $image_formats.each do |fmt|
        if filename.include?(fmt) == true
            return true
        end
    end
    return false
end
