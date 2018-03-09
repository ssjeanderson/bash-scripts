# Exemplo de for percorrendo linhas em uma variavel

lista='primeira linha
segunda linha
terceira linha'

for i in $lista; do
	echo "dn: $i"
done


####
# Comenta todas as linhas de um arquivo
sed -i.old -e 's/^/#/' arquivo
