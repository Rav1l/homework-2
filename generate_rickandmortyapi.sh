MODULE="Modules/RickAndMortyApiNetworking/Sources/RickAndMortyApiNetworking/"

openapi-generator generate -i "rickAndMortyAPI.yml" --reserved-words-mappings Character=chdf -g swift5 --additional-properties=responseAs=AsyncAwait -o "rickAndMortyAPI"
rm -r $MODULE""*
cp -R "rickAndMortyAPI/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "rickAndMortyAPI"
