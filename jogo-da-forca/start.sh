#!/bin/bash

word="mochila" # Palavra a ser adivinhada

# Cria uma string com espaços em branco para as letras da palavra
masked_word=$(echo "$word" | sed 's/./_ /g')

# Função para exibir a interface do jogo
play_game() {
  attempts=6
  guessed_letters=""

  while (( attempts > 0 )); do
    dialog --title "Jogo da Forca" --msgbox "Palavra: $masked_word\n\nTentativas Restantes: $attempts\nLetras já usadas: $guessed_letters" 12 40

    dialog --title "Digite uma letra" --inputbox "Digite uma letra:" 8 30 2> letter

    letter=$(cat letter)

    if [[ $letter =~ [a-zA-Z] ]]; then
      # Verifica se a letra já foi adivinhada antes
      if [[ $guessed_letters == *"$letter"* ]]; then
        dialog --title "Letra repetida" --msgbox "Você já adivinhou a letra $letter antes." 6 30
        continue
      fi

      guessed_letters+="$letter "

      # Verifica se a letra existe na palavra
      if [[ $word == *"$letter"* ]]; then
        masked_word_new=""
        correct_guess=false

        # Atualiza a palavra mascarada com as letras corretas
        for ((i=0; i<${#word}; i++)); do
          if [[ ${word:i:1} == $letter ]]; then
            masked_word_new+="$letter "
            correct_guess=true
          else
            masked_word_new+="${masked_word:i*2:1} "
          fi
        done

        masked_word=$masked_word_new

        if [[ $masked_word == *"_ "* ]]; then
          continue
        else
          dialog --title "Parabéns!" --msgbox "Você adivinhou a palavra corretamente: $word" 7 40
          exit 0
        fi
      else
        attempts=$((attempts - 1))
        if (( attempts == 0 )); then
          dialog --title "Fim do jogo" --msgbox "Suas tentativas acabaram. A palavra correta era: $word" 7 40
          exit 0
        else
          continue
        fi
      fi
    else
      dialog --title "Entrada inválida" --msgbox "Por favor, digite uma letra válida." 6 30
    fi
  done
}

play_game
