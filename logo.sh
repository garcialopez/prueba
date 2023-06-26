#!/bin/bash

logo=(
"  _________  _________  ________  ___       __   ___       __ "
" /_ _  _ _/ / _______/ / ______/ / _ \     / /  / _ \     /  \ "
"    / /    / /____    / /       / / \ \   / /  / / \ \   / /\ \ "
"   / /    / _____/   / /       / /   \ \_/ /  / /   \ \_/ /  \ \ "
"  / /    / /______  / /_____  / /     \   /  / /     \   /    \ \ "
" /_/    /_________/ \______/ /_/       \_/  /_/       \_/      \_\ "
)


cargando=(
"#### #### ####  #### #### ##   # ###  ####"
"#    #  # #  # # ##  #  # # #  # #  # #  #"
"#    #### ###  #   # #### #  # # #  # #  #"
"#### #  # #  # ####  #  # #  ##  # #  #### "
)



colorLogo="\e[34m" # Color azul
reset="\e[0m" # Restablecer el color

echo -e "$colorLogo" # Establecer el color amarillo

for line in "${logo[@]}"; do
  printf "%s\n" "$line"
  sleep 0.5 # Pausa de medio segundo entre líneas
done

echo -e "$reset" # Restablecer el color

# -------------------------------------------------
echo -e "\e[33m"
for line in "${cargando[@]}"; do
     printf "%s\n" "$line"
     sleep 0.5
done
