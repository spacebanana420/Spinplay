$video_formats = [".mp4", ".mov", ".mkv", ".webm", ".avi", ".m4v", ".gif"]
$audio_formats = [".flac", ".mp3", ".m4a", ".wav", ".ogg", ".opus"]
$image_formats = [".png", ".jpg", ".bmp", ".tiff", ".tif", ".TIF", ".avif", ".heic", ".heif", ".webp"]

$volume = "-volume 10"
$showmode = ""
$width = ""
$height = ""
$loop = ""
$autoexit = "-autoexit"

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
