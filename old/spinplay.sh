#!/bin/bash

#Here you can set the defaults for when these arguments are unspecified
volume=7
width=auto
height=auto
fullscreen=0
showmode=1
noborder=0
folders=()
# function argcheck () {
#     opt=(); count=0 next=""
#     for i in "$@"
#     do
#         case $i in
#             -v)
#                 next="-v"
#             ;;
#             -x)
#                 next="-y"
#             ;;
#             -y)
#                 next="-y"
#             ;;
#             -l)
#                 next="-l"
#             ;;
#             *)
#                 if [[ $i != "" && $next != "" ]]
#                 then
#                     opt[$next]=$i; next=""
#                 elif [[ $i != "" ]]
#                     file=$i
#                     return
#                 fi
#             ;;
#         esac
#     done
#
#     for i in "-v" "-x" "-y" "-l"
#     do
#         if [[ $opt[$i] != "" ]]
#         then
#             if [[ $i != "-l" ]]
#             then
#                 options+="$i ${opt[$i]} "
#             else
#                 options+="$i "
#             fi
#         fi
#     done
# }

function help () {
    echo "SpinPlay (version 0.5-git)"; echo "------------"
    echo "Options:"; echo "ffplay options: -volume [volume], -x [width], -y [height], -loop [times] -fs [0/1]"
    echo "Script options: -random - plays randomly all media in current directory;  -dir - plays all media in current directory"
    echo "Keyboard and mouse controls while playing: q/esc - quit;  f/double click - toggle fullscreen;  m - mute;  p/space - pause;  9 and 0 - decrease and increase volume;  right mouse click - set position in media timeline"
    echo ""; echo "This script integrates all of FFplay's capabilities. Type 'ffplay -h' or 'man ffplay' for a full list of arguments"
}

#todo: shuffle, default width for audio and video, frequent files, frequent folders, disable autoexit for images, go to dir, auto loop on short media

function spinmenu () {
    num=1
    echo "SpinPlay (version 0.5-git)"; echo "------------"
    if [[ ${#folders[@]} != 0 ]]
    then
        echo "Saved Folders:"
        for i in "${folders[@]}"
        do
            echo "$num: $i"; ((num+=1))
        done
        echo ""
    fi

    while true
    do
        echo "Files:"
#         fileprint=""
#         for i in *
#         do
#             contents[$num]=$i; fileprint+="$num: $i  "; ((num+=1))
#         done
#         echo $fileprint
        ls
        echo ""; echo "Choose a file or a folder or type '..' to jump to parent folder or type 'quit' or 'q' to leave"
        read playfile
        if [[ -d $playfile ]]; then cd "$playfile";
        elif [[ $playfile == ".." ]]; then cd ..;
        elif (("$playfile" != 0)) #errors-
        then
            for i in "${folders[@]}"
            do
                if [[ $i == ${folders[$playfile-1]} ]]
                then
                    cd $i
                    break
                fi
            done
        elif [[ $playfile == "quit" || $playfile == "q" ]]; then break;
        else readplay
        fi
        echo ""
    done
}

function readplay () {
    if [[ -f $playfile ]]
    then
        ffplay $scriptopt $useropt "$playfile"
    else
        for i in *
        do
            if [[ $i == *"$playfile"* && -f $i ]]
            then
                playfile=$i
                ffplay $scriptopt $useropt "$playfile"
                return
            fi
        done
        for i in *
        do
            if [[ $i == *"$playfile"* && -d $i ]]
            then
                playfile=$i
                cd "$i"
                return
            fi
        done
    fi
}

function defaultplay () {
    ffplay $scriptopt $useropt "$playfile"
}


function playdir () {
    for i in *
    do
        if [[ -f "$i" ]]
        then
            ffplay $scriptopt $useropt "$i"
        fi
    done
}

# function shuffleplay () {
#     for i in *
#     do
#
#     done
# }


for i in "$@"
do
    if [[ -f "$i" ]]
    then
        playfile="$i"
    elif [[ $i != *"-random"* && $i != *"-dir"* ]]
    then
        useropt+="$i "
    fi
done

if [[ "$@" != *"-volume"* ]]; then scriptopt+="-volume $volume "; fi
if [[ "$@" != *"-autoexit"* && $playfile != *.png && $playfile != *.jpg && $playfile != *.tiff && $playfile != *.avif && $playfile != *.heic && $playfile != *.bmp && $playfile != *.webp && $playfile != *.jfif && $playfile != *.jpeg ]]; then scriptopt+="-autoexit "; fi
if [[ "$@" != *"-fs"* && $fullscreen == 1 ]]; then scriptopt+="-fs "; fi
if [[ "$@" != *"-noborder"* && $noborder == 1 ]]; then scriptopt+="-noborder "; fi
if [[ "$@" != *"-x"* && $width != "auto" ]]; then scriptopt+="-x $width "; fi
if [[ "$@" != *"-y"* && $height != "auto" ]]; then scriptopt+="-y $height "; fi
if [[ "$@" != *"-showmode"* ]] && (($showmode >= 0)) && (($showmode <=2)); then scriptopt+="-showmode $showmode "; fi

if [[ "$@" == *"-dir"* ]]
then
    playdir
elif [[ $playfile != "" ]]
then
    defaultplay
else
    spinmenu
fi
