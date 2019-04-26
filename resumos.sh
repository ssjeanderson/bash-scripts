# Exemplo de for percorrendo linhas em uma variavel

lista='primeira linha
segunda linha
terceira linha'

for i in $lista; do
	echo "dn: $i"
done

### While percorrer arquivo
input="/path/to/txt/file"
while IFS= read -r var
do
  echo "$var"
done < "$input"


####

# Comenta todas as linhas de um arquivo
sed -i.old -e 's/^/#/' arquivo

# executar como expect do PAC. seta o color do vim
alias vim='vim -c "color desert"'; history -d $((HISTCMD-1))

# Captura saida do tcpdump em tempo real
tcpdump -n --immediate-mode -l | grep stuff

