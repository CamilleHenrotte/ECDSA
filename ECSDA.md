# ECDSA

## Exercise 0 - What pieces of information go in to an EIP 712 delimiter, and what could go wrong if those were omitted?

The EIP712 delimiter is a hash composed of the following information :
- the name of the dApp
- the version of the dApp
- the chainId 
- the verifying contract
- the salt

All these information are meant to prevent that the signature be used for another dApp that was not intended.
## Exercise 2
By looking on the ethereum mainnet, I was able to find the same contract deployed and to reuse the signature already there.
 ## Exercise 3
 This contract has a medium severity vulnerability mainly due to two issues:

- First, if the owner is uninitialized or set to address(0), then anyone could potentially call claimAirdrop successfully. Indeed, the openzeppelin library is imprted but not use so it is using the Solidity's native ecrecover which returns address(0) if the signature is incorrect.

- Second, there’s no inclusion of a domain separator like the chainId or the contract’s own address. That makes the contract vulnerable to replay attacks—if someone deployed the same contract on another chain or another address, any signature valid on the original deployment could be reused there to claim the airdrop again.

