#!/bin/bash

# Cores disponíveis
cores=("Vermelho" "Verde" "Azul" "Amarelo" "Rosa" "Laranja")

# Escolhe uma cor aleatória
random_color=${cores[$((RANDOM % ${#cores[@]}))]}

# Função para exibir a interface do jogo
play_game() {
  attempts=3

  while (( attempts > 0 )); do
    dialog --title "Adivinhe a Cor!" --menu "Qual é a cor correta?" 10 50 5 \
      "${cores[0]}" "" \
      "${cores[1]}" "" \
      "${cores[2]}" "" \
      "${cores[3]}" "" \
      "${cores[4]}" "" \
      "${cores[5]}" "" 2> selected_color

    selected=$(cat selected_color)

    if [[ $selected == "$random_color" ]]; then
      dialog --title "Parabéns!" --msgbox "Você acertou a cor!" 6 30
      exit 0
    else
      dialog --title "Tente novamente!" --msgbox "Você errou. Tente novamente." 6 30
    fi

    attempts=$((attempts - 1))
  done

  dialog --title "Fim do jogo" --msgbox "Suas tentativas acabaram. A cor correta era $random_color." 7 40
}

play_game
