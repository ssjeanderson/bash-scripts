# Exemplo de for percorrendo linhas em uma variavel

lista='primeira linha
segunda linha
terceira linha'

for i in $lista; do
	echo "dn: $i"
done
