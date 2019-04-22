# rootca
A minimal, dockerised, root certificate authority. Designed for testing and development purposes only.

Relies on the `MY_DOMAIN` environment variable which represents the domain you want to be the RootCA for.

Certificates are saved into the `/certs` folder which should be mounted from the host as a volume to be obtained.

## Running
To run the container use the following commands, where `subsiteN` equates to the subdomains you need certs for.

```
docker run -e MY_DOMAIN="development.local" -v /tmp/certs:/certs rootca subsite1 subsite2
```

The output of the above command will look like this:

```
  -  Creating /certs/development.local to store certs

  -  Generating key and self-signed cert for RootCA
Generating a RSA private key
............................+++++
...........+++++
writing new private key to '/certs/development.local/ca-key.key'
-----

  +  RootCA cert @ /certs/development.local/ca-cert.pem

  -  Creating cert for subsite1
Generating RSA private key, 2048 bit long modulus (2 primes)
....................................................................+++++
....................+++++
e is 65537 (0x010001)
Signature ok
subject=CN = subsite1.development.local
Getting CA Private Key
/certs/development.local/subsite1.development.local/fullchain.pem: OK

  +  Bundle available @ /certs/development.local/subsite1.development.local/fullchain.pem

  -  Creating cert for subsite2
Generating RSA private key, 2048 bit long modulus (2 primes)
.................................+++++
..................................+++++
e is 65537 (0x010001)
Signature ok
subject=CN = subsite2.development.local
Getting CA Private Key
/certs/development.local/subsite2.development.local/fullchain.pem: OK

  +  Bundle available @ /certs/development.local/subsite2.development.local/fullchain.pem
```

To review and confirm, you can run the following from the host with `openssl`.

```
openssl verify \
    -CAfile /tmp/certs/development.local/ca-cert.pem \
    /tmp/certs/development.local/subsite1.development.local/fullchain.pem

/tmp/certs/development.local/subsite1.development.local/fullchain.pem: OK
```