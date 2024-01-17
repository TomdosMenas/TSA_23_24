#!/bin/bash

# Início das equipas e pontuações
equipas=("Benfica" "Sporting" "Porto" "Braga" "Boavista" "Moreirense" "Portimonense" "Farense" "Famalicão" "Arouca" "Vitória" "Casa Pia" "Estrela Amadora" "Gil Vicente" "Estoril" "Vizela" "Rio Ave" "Chaves")
pontuacoes=()

# Número de jornadas
num_jornadas=34

# Inicia as pontuações de todas as equipas com zero
for ((i=0; i<18; i++)); do
  pontuacoes[$i]=0
done

# Função para mostrar a classificação atual
mostrar_classificacao() {
  while IFS='-' read -r equipa pontuacao; do
    equipa=$(echo "$equipa")  
    echo "$equipa"
  done < Jornadas/Classificacao.txt
  echo " "
}

# Função para mostrar os resultados de uma jornada específica
mostrar_resultados_jornada() {
  read -p "Digite o número da jornada (1 a 34): " numero_jornada

  # Nome do arquivo na pasta Jornadas
  nome_arquivo="Jornadas/Jornada${numero_jornada}.txt"

  # Verificar se o arquivo existe e ler o conteúdo
  if [ -e "$nome_arquivo" ]; then
    echo
    echo "Resultados da Jornada $numero_jornada:"
    cat "$nome_arquivo"
    echo
  else
    echo
    echo "A jornada $numero_jornada não foi disputada ou o ficheiro não existe."
    echo
  fi
}

# Função para encontrar a próxima jornada não disputada
encontrar_proxima_jornada() {
  ultima_jornada_disputada=0
  for ((i=1; i<=num_jornadas; i++)); do
    nome_arquivo="Jornadas/Jornada${i}.txt"

    # Verificar se o arquivo existe e contém resultados
    if [ -e "$nome_arquivo" ] && grep -q "Resultados da Jornada" "$nome_arquivo"; then
      ultima_jornada_disputada=$i
    fi
  done

  proxima_jornada=$((ultima_jornada_disputada + 1))

  if [ "$proxima_jornada" -le "$num_jornadas" ]; then
    mostrar_resultados_jornada "$proxima_jornada"
  else
    echo "Todas as jornadas foram disputadas."
  fi
}

# Função para lançar resultados da próxima jornada
lancar_resultados_proxima_jornada() {
  read -p "Digite o número da próxima jornada a ser disputada (1 a 34): " numero_jornada

  nome_arquivo="Jornadas/Jornada${numero_jornada}.txt"

  # Verificar se o arquivo existe e não contém resultados
  if [ -e "$nome_arquivo" ] && ! grep -q "Resultados da Jornada" "$nome_arquivo"; then
    echo "Digite os resultados da Jornada $numero_jornada (formato: equipa1 vs equipa2 - golos1,golos2):"
    read -p "Resultado: " resultados
    echo "Resultados da Jornada $numero_jornada:" > "$nome_arquivo"
    echo "$resultados" >> "$nome_arquivo"
    echo "Resultados lançados com sucesso."
  else
    echo "A jornada $numero_jornada não está disponível para lançamento de resultados ou o ficheiro já contém resultados."
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
  echo "2 - Ver resultados de uma jornada"
  echo "3 - Ver próxima jornada"
  echo "4 - Lançar resultados da próxima jornada"
  echo "5 - Sair"

  read -p "Escolha uma opção (1 a 5): " escolha

  case $escolha in
    1)
      echo " "
      mostrar_classificacao
      ;;
    2)
      echo " "
      mostrar_resultados_jornada
      ;;
    3)
      echo " "
      echo "A próxima jornada é a primeira jornada que não tem resultados"
      encontrar_proxima_jornada
      ;;
    4)
      echo " "
      lancar_resultados_proxima_jornada
      ;;
    5)
      echo " "
      echo "A sair..."
      exit
      ;;
    *)
      echo "Opção inválida. Tente novamente."
      ;;
  esac
done
