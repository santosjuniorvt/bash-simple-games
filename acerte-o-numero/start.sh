#!/bin/bash

# Gera um número aleatório de 1 a 30
number=$((RANDOM % 30 + 1))

echo "Bem-vindo ao jogo Adivinhe o Número!"
echo "Tente adivinhar o número entre 1 e 30."

attempts=0
max_attempts=5

while (( attempts < max_attempts )); do
  echo -n "Digite sua resposta: "
  read guess

  # Verifica se o input é um número válido
  if ! [[ $guess =~ ^[0-9]+$ ]]; then
    echo "Por favor, digite um número válido."
    continue
  fi

  # Compara o palpite com o número gerado
  if (( guess < number )); then
    echo "Muito baixo! Tente novamente."
  elif (( guess > number )); then
    echo "Muito alto! Tente novamente."
  else
    echo "Parabéns! Você acertou o número."
    exit 0
  fi

  attempts=$((attempts + 1))
done

echo "Suas tentativas acabaram. O número correto era $number."
