# ECDSA

## What pieces of information go in to an EIP 712 delimiter, and what could go wrong if those were omitted?

The EIP712 delimiter is a hash composed of the following information :
- the name of the dApp
- the version of the dApp
- the chainId 
- the verifying contract
- the salt

All these information are meant to prevent that the signature be used for another dApp that was not intended.
