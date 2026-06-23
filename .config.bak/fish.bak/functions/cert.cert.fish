function cert.cert
  openssl x509 -text -noout -in $argv
end
