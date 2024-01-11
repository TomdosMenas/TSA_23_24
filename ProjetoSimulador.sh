#!/bin/bash

# Inicialização das equipas e pontuações
equipas=("Benfica" "Sporting" "Porto" "Braga" "Boavista" "Moreirense" "Portimonense" "Farense" "Famalicão" "Arouca" "Vitória" "Casa Pia" "Estrela Amadora" "Gil Vicente" "Estoril" "Vizela" "Rio Ave" "Chaves")
pontuacoes=()

# Número de jornadas
num_jornadas=34

# Inicializa as pontuações de todas as equipas com zero
for ((i=0; i<18; i++)); do
  pontuacoes[$i]=0
done

# Função para mostrar a classificação atual
mostrar_classificacao() {
  while IFS='-' read -r equipa pontuacao; do
  equipa=$(echo "$equipa")  # Remove espaços em branco no início e no final
  echo "$equipa"
done < Jornadas/Classificacao.txt
echo " ";
}

# Função para mostrar os resultados de uma ou mais jornadas
mostrar_resultados_jornadas() {
  read -p "Digite o número da jornada (1 a 15): " numero_jornada

# Nome do arquivo na pasta Jornadas
nome_arquivo="Jornadas/Jornada${numero_jornada}.txt"

# Verificar se o arquivo existe e ler o conteúdo
if [ -e "$nome_arquivo" ]; then
  echo ;
  cat "$nome_arquivo"
  echo ;
  echo ;
else
  echo ;
  echo "A jornada não foi disputada."
  echo ;
fi
}

# Exibir cabeçalho
echo "---------------------------------------"
echo "         Liga Portugal Betclic"
echo "---------------------------------------"

# Menu principal
while true; do
  echo "Menu Principal:"
  echo "1 - Ver classificação atual"
  echo "2 - Ver jornada(s)"
  echo "3 - Sair"

  read -p "Escolha uma opção (1 a 3): " escolha

  case $escolha in
    1)
      echo " ";
      mostrar_classificacao
      ;;
    2)
      echo " ";
      mostrar_resultados_jornadas
      ;;
    3)
      echo " ";
      echo "Saindo..."
      exit
      ;;
    *)
      echo "Opção inválida. Tente novamente."
      ;;
  esac
done
