# OBS.:
# - A técnica pode ser lenta e potencialmente insegura.
# - Alguns arquivos podem ser modificados na inicialização, prejudicando os resultados da exportação.
# - Às vezes, executar um contêiner é simplesmente impossível (pode ser quebrado).

param($image='helloworld')

if ( $image -eq "helloworld" )
{
    Write-Output "O filesystem gerado agora será apenas de teste, com a imagem helloworld, passe a referencia da imagem com o parametro -image"
}

$OUTPUT="${pwd}"+'\'+"$image"
$OUTPUT_FILE="$image"+'.tar.gz'
$CONT_ID=docker create $image

# # debug
# Write-Output $OUTPUT
# Write-Output $OUTPUT_FILE

docker export $CONT_ID -o $OUTPUT_FILE
mkdir $OUTPUT
tar -xvzf $OUTPUT_FILE --directory $OUTPUT
rm -Force ./$OUTPUT_FILE
