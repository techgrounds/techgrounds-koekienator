# install openssl first! winget install openssl | winget update openssl
# add openssl to PATH default "C:\Program Files\OpenSSL-Win64\bin"
openssl req -x509 -newkey rsa:4096 -nodes -subj "/C=US/ST=private/L=province/O=city/CN=techgrounds" -keyout keys/certkey.pem -out keys/certcert.pem -days 365
openssl pkcs12 -inkey keys/certkey.pem -in keys/certcert.pem -export -out cert/webcert.pfx -password pass:
remove-item keys/certkey.pem
remove-item keys/certcert.pem