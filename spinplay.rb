require "./lib/commands.rb"
require "./lib/ffsettings.rb"
require "./lib/readconfig.rb"

$startingdir = Dir.pwd()
if "ABCDEFGHIJKLMNOPQRSTUVWXYZ".include?($startingdir.chars[0]) == true && $startingdir.chars[1] == ":"
    $platform = 1
else
    $platform = 0
end

$volume = "-volume 12"; $safecheck = true; $fullscreen = false


def clear_terminal()
    if $platform == 0
        system("clear")
    else
        system("cls")
    end
end

def filebrowser()
    while true
        clear_terminal()
        paths, paths_num = print_dirs()
        answer = gets.chomp
        if read_command(answer) == false
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
    if File::file?(path) == true
        playmedia(path)
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

readconfig()
filebrowser()
