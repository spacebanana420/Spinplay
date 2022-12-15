#!/bin/bash

#Here you can set the defaults for when these arguments are unspecified
volume=5
width=auto
height=auto
fullscreen=0

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
    echo "SpinPlay (version 0.1-git)"; echo "------------"
    echo "Options:"; echo "ffplay options: -volume [volume], -x [width], -y [height], -loop [times] -fs [0/1]"
    echo "Script options: -random - plays randomly all media in current directory;  -dir - plays all media in current directory"
    echo "Keyboard and mouse controls while playing: q/esc - quit;  f/double click - toggle fullscreen;  m - mute;  p/space - pause;  9 and 0 - decrease and increase volume"
    echo ""; echo "This script integrates all of FFplay's capabilities. Type 'ffplay -h' or 'man ffplay' for a full list of arguments"
}

function defaultplay () {
    if [[ $playfile != "" ]]
    then
        ffplay $scriptopt $useropt "$playfile"
    else
        ls
        echo "Choose a file"
        read playfile
        if [[ -f $playfile ]]
        then
            ffplay $scriptopt $useropt "$playfile"
        else
            for i in *
            do
                if [[ $i == *"$playfile"* ]]
                then
                    playfile=$i
                    ffplay $scriptopt $useropt "$playfile"
                    break
            done
        fi
    fi
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


if [[ "$@" != *"-volume"* ]]; then scriptopt+="-volume $volume "; fi
if [[ "$@" != *"-autoexit"* ]]; then scriptopt+="-autoexit "; fi
if [[ "$@" != *"-fs"* && $fullscreen == 1 ]]; then scriptopt+="-fs "; fi

for i in "$@"
do
    if [[ -f "$i" ]]
    then
        playfile="$i"
    elif [[ $i != *"random"* && $i != *"dir"* ]]
    then
        useropt+="$i "
    fi
done

if [[ "$@" == *"-dir"* ]]
then
    playdir
else
    defaultplay
fi
