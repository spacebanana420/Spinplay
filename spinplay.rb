$video_formats = [".mp4", ".mov", ".mkv", ".webm", ".avi", ".m4v", ".gif"]
$audio_formats = [".flac", ".mp3", ".m4a", ".wav", ".ogg", ".opus"]

def get_platform()
    starting_path = Dir::pwd()
    if "ABCDEFGHIJKLMNOPQRSTUVWXYZ".include?(starting_path.chars[0]) == true && starting_path.chars[1] == ":"
        $platform = 1
    else
        $platform = 0
    end
end

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

def clear_terminal()
    if $platform == 0
        system("clear")
    else
        system("cls")
    end
end

def filebrowser()
    while true
        paths, paths_num = print_dirs()
        answer = gets.chomp; answernum = answer.to_i
        count=0
        case answernum
        when 0
            return
        when 1
            Dir::chdir("..")
        else
            paths.each do |path|
                if answernum == paths_num[count]
                    open_path(path)
                    break
                end
                count+=1
            end
        end
        clear_terminal()
    end
end

def open_path(path)
    if is_video(path) == true
        settings = "-volume 10 -loglevel 16 -showmode 0 -autoexit"
    else
        settings = "-x 400 -y 400 -volume 10 -loglevel 16 -showmode 1 -autoexit"
    end

    if File::file?(path) == true
        #puts "Now playing #{path}\nSpace: pause\n9 and 0: decrease/increase volume\nQ: quit"
        Thread.new {system("ffplay #{settings} \"#{path}\"")}
    else
        Dir::chdir(path)
    end
end

def print_dirs()
    finalstring = "0: Exit     1: Go back\n---Directories---\n"
    paths = Dir::children(".")
    dirs = Array.new(); files = Array.new()
    allpaths = Array.new(); allpaths_num = Array.new()

    paths.each do |path|
        if File::file?(path) == true
            if check_if_supported(path) == true
                files.push(path)
            end
        else
            dirs.push(path)
        end
    end
    count=2
    pathsprinted=0
    dirs.each do |dir|
        if pathsprinted == 3 then pathsprinted = 0; finalstring += "\n" end
        finalstring += "#{count}: #{dir}     "

        allpaths.push(dir); allpaths_num.push(count)
        count+=1; pathsprinted+=1
    end
    pathsprintedi=0
    finalstring += "\n---Files---\n"
    files.each do |file|
        if pathsprinted == 3 then pathsprinted = 0; finalstring += "\n" end
        finalstring += "#{count}: #{file}     "

        allpaths.push(file); allpaths_num.push(count)
        count+=1; pathsprinted+=1
    end
    finalstring += "\n"

    puts finalstring
    return allpaths, allpaths_num
end

get_platform()
filebrowser()
