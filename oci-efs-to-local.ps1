# Este script pode ser usado para replicar localmente o filesystem da imagem
# de container, você precisará:
# - Ter o docker já em execução (não apenas instalado)
# - Já está autenticado logado no registry, para caso de registrys privados

# Use [nome_script].ps1 -image <Referência da imagem no registry> -out <nome da pasta que será gerada para despejo do conteúdo>
# Obrigatório: -image
# Opicional: -out

# OBS.:
# - A técnica pode ser lenta e potencialmente insegura.
# - Alguns arquivos podem ser modificados na inicialização, prejudicando os resultados da exportação.
# - Às vezes, executar um contêiner é simplesmente impossível (pode ser quebrado).


param($image='helloworld', $out=$image)

if ( $image -eq "helloworld" )
{
    Write-Output "O filesystem gerado agora será apenas de teste, com a imagem helloworld, passe a referencia da imagem com o parametro -image"
}

if ( $out -eq $image )
{
    Write-Output "A saida será jogada em uma pasta com o mesmo nome passado no parametro -image, caso precise/necessite/enfrente problemas, crie um caminho customizado com -out"
    $OUTPUT="${pwd}"+'\'+"$image"
    $OUTPUT_FILE="$image"+'.tar.gz'
}
else 
{
    $OUTPUT="${pwd}"+'\'+"$out"
    $OUTPUT_FILE="$out"+'.tar.gz'
}

$CONT_ID=docker create $image

# # debug
# Write-Output $OUTPUT
# Write-Output $OUTPUT_FILE

Start-Sleep -Seconds 4
docker export $CONT_ID -o $OUTPUT_FILE
mkdir $OUTPUT
tar -xvzf $OUTPUT_FILE --directory $OUTPUT
rm -Force ./$OUTPUT_FILE
