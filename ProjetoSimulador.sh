#!/bin/bash

# Função para gerar um número aleatório entre 0 e 3
random_number() {
  echo $((RANDOM % 4))
}

# Inicialização das equipas e pontuações
equipas=("Benfica" "Sporting" "Porto" "Braga" "Boavista" "Moreirense" "Portimonense" "Farense" "Famalicão" "Arouca" "Vitória" "Casa Pia" "Estrela Amadora" "Gil Vicente" "Estoril" "Vizela" "Rio Ave" "Chaves")
pontuacoes=()

# Inicializa as pontuações de todas as equipas com zero
for ((i=0; i<18; i++)); do
  pontuacoes[$i]=0
done

# Número de jornadas
num_jornadas=37

# Função para simular um jogo entre duas equipas
simular_jogo() {
  equipa_casa=$1
  equipa_fora=$2

  # Simula o resultado do jogo
  golos_casa=$(random_number)
  golos_fora=$(random_number)

  # Atualiza as pontuações com base no resultado
  pontuacoes[$equipa_casa]=$((pontuacoes[$equipa_casa] + $golos_casa))
  pontuacoes[$equipa_fora]=$((pontuacoes[$equipa_fora] + $golos_fora))

  # Atualiza o saldo de gols
  saldo_golos_casa=$((pontuacoes[$equipa_casa] - pontuacoes[$equipa_fora]))
  saldo_golos_fora=$((pontuacoes[$equipa_fora] - pontuacoes[$equipa_casa]))

  # Exibe o resultado do jogo com os nomes das equipas
  echo "${equipas[$equipa_casa]} $golos_casa - $golos_fora ${equipas[$equipa_fora]} | Saldo de golos: $saldo_golos_casa - $saldo_golos_fora"
}

# Simula todas as jornadas
for ((jornada=1; jornada<=$num_jornadas; jornada++)); do
  echo "Jornada $jornada:"
  
  for ((i=0; i<9; i++)); do
    if [ $((jornada % 2)) -eq 1 ]; then
      simular_jogo $i $((i + 9))
    else
      simular_jogo $((i + 9)) $i
    fi
  done
done

# Imprime a tabela organizada com as respetivas posições por ordem de pontuação
echo "Classificação Final:"
for ((i=0; i<18; i++)); do
  echo "${equipas[$i]}: ${pontuacoes[$i]} pontos | Saldo de golos: $((pontuacoes[$i] - pontuacoes[(($i + 9) % 18)]))"
done | sort -k3,3nr -k6,6nr
