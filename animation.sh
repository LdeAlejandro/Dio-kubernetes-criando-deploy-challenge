#!/bin/bash

typewriter() {
  text="$1"
  length=${#text}
  
  for ((i=0; i<length; i++)); do
    char="${text:$i:1}"
    
    if [[ "$char" == " " ]]; then
      printf " "
    else
      printf "$char"
    fi
    
    # Controle de tempo - ajuste o valor para mudar a velocidade
    # 0.001 = muito rápido, 0.01 = rápido, 0.1 = normal
    sleep 0.005
  done
  
  echo ""
}

# Chamada da função com o primeiro argumento passado
typewriter "$1"