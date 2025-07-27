# view color as bg
for i in {0..255}; do printf "\033[48;5;%sm %3s \033[0m" $i $i; ((i % 16 == 15)) && echo; done

# view color as fg
for i in {0..255}; do printf "\033[38;5;%sm %3s \033[0m" $i $i; ((i % 16 == 15)) && echo; done
