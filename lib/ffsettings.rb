$video_formats = [".mp4", ".mov", ".mkv", ".webm", ".avi", ".m4v", ".gif"]
$audio_formats = [".flac", ".mp3", ".m4a", ".wav", ".ogg", ".opus"]

$volume = "-volume 10"
$showmode = ""
$width = ""
$height = ""
$loop = ""

def is_video(filename)
    $video_formats.each do |fmt|
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
    return false
end
