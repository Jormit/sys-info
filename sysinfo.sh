#!/bin/bash

print_line() {
    tput cup $current_row 0
    echo -e "$1"
    ((current_row=current_row+1))
}

cols=$(tput cols)
rows=$(tput lines)
username="$USER@$NAME"
dist=$(awk '/PRETTY_NAME/' /etc/os-release | cut -d '=' -f 2 | cut -d '"' -f 2)
cpu_type=$(uname -p)
dist="${dist} ${cpu_type}"
cpu_info=$(cat /proc/cpuinfo | grep "model name" | uniq | cut -d ':' -f 2 | xargs)
terminal=$TERM
shell=$SHELL
kernel=$(uname -r)
memory=$(cat /proc/meminfo | grep "MemTotal" | uniq | cut -d ':' -f 2 | xargs )
packages=$(dpkg --list | wc --lines)

current_row=0
tput clear
print_line "${username}"
print_line "\e[1mdist:    \e[0m ${dist}"
print_line "\e[1mterminal:\e[0m ${terminal}"
print_line "\e[1mpackages:\e[0m ${packages}"
print_line "\e[1mcpu:     \e[0m ${cpu_info}"
print_line "\e[1mshell:   \e[0m ${shell}"
print_line "\e[1mkernel:  \e[0m ${kernel}"
print_line "\e[1mmemory:  \e[0m ${memory}"

