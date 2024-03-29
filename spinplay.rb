require "./lib/commands.rb"
require "./lib/ffsettings.rb"
require "./lib/readconfig.rb"
require "./lib/tui.rb"

$startingdir = Dir.pwd()
# if "ABCDEFGHIJKLMNOPQRSTUVWXYZ".include?($startingdir.chars[0]) == true && $startingdir.chars[1] == ":"
#     $platform = 1 #windoos
# else
#     $platform = 0 #not windoos
# end

$volume = "-volume 12"; $safecheck = true; $fullscreen = false; $pathsperline = 3; $linesperblock = 10; $linespacing = "     "

def filebrowser()
    while true
        clear_terminal()
        paths, paths_num = print_dirs()
        answer = gets.chomp
        if read_command(answer) == false && checkifnumber(answer) == true
            answernum = answer.to_i
            case answernum
            when 0
                return
            when 1
                Dir::chdir("..")
            else
                count=0
                paths.each do |path|
                    if answernum == paths_num[count]
                        open_path(path)
                        break
                    end
                    count+=1
                end
            end
        end
    end
end

def open_path(path)
    if File.file?(path) == true
        playmedia(path)
    else
        Dir.chdir(path)
    end
end

def print_dirs()
    green = foreground("green")
    default = foreground("default")
    yellow = foreground("yellow")

    finalstring = "#{Dir.pwd()}\n\n#{yellow}0:#{default} Exit#{$linespacing}#{green}1:#{default} Go back\n\n#{yellow}---Directories---#{default}\n"
    paths = Dir.children(".")
    dirs = Array.new(); files = Array.new()
    allpaths = Array.new(); allpaths_num = Array.new()

    paths.each do |path|
        if path.chars[0] != "."
            if File.file?(path) == true
                if check_if_supported(path) == true
                    files.push(path)
                end
            else
                dirs.push(path)
            end
        end
    end
    count=2
    pathsprinted=0
    dirs.each do |dir|
        if pathsprinted == $pathsperline then pathsprinted = 0; finalstring += "\n" end
        finalstring += "#{green}#{count}:#{default} #{dir}#{$linespacing}"

        allpaths.push(dir); allpaths_num.push(count)
        count+=1; pathsprinted+=1
    end
    pathsprintedi=0
    finalstring += "\n#{yellow}---Files---#{default}\n"
    files.each do |file|
        if pathsprinted == $pathsperline then pathsprinted = 0; finalstring += "\n" end
        finalstring += "#{green}#{count}:#{default} #{file}#{$linespacing}"

        allpaths.push(file); allpaths_num.push(count)
        count+=1; pathsprinted+=1
    end

    finalstring += "\n\n"
    puts finalstring
    return allpaths, allpaths_num
end

def find_path(searchedname)
    clear_terminal()
    finalstring = "Found the following paths that contain #{searchedname}:\n\n---Directories---\n"
    paths = Dir.children(".")
    dirs = Array.new(); files = Array.new()

    paths.each do |path|
        if path.chars[0] != "."
            if File::file?(path) == true
                if check_if_supported(path) == true
                    files.push(path)
                end
            else
                dirs.push(path)
            end
        end
    end
    count=2
    pathsprinted=0
    dirs.each do |dir|
        if pathsprinted == $pathsperline then pathsprinted = 0; finalstring += "\n" end
        if dir.include?(searchedname) == true
            finalstring += "#{count}: #{dir}#{$linespacing}"
            pathsprinted+=1
        end
        count+=1
    end
    pathsprintedi=0
    finalstring += "\n---Files---\n"
    files.each do |file|
        if pathsprinted == $pathsperline then pathsprinted = 0; finalstring += "\n" end
        if file.include?(searchedname) == true
            finalstring += "#{count}: #{file}#{$linespacing}"
            pathsprinted+=1
        end
        count+=1
    end

    finalstring += "\n\nPress any key to continue"
    puts finalstring
    gets
end

def checkifnumber(text)
    if text == ""
        return false
    end
    text.chars().each do |char|
        if "0123456789".include?(char) == false
            return false
        end
    end
    return true
end

readconfig()
filebrowser()
