# Certificate NFT

A non-transferable NFT smart contract for issuing certificates on the Mandala Chain. This contract allows authorized entities to mint certificate NFTs with metadata and images stored on IPFS.

## Features

- Non-transferable NFTs (Soul-bound tokens)
- IPFS integration for metadata and images
- Fully compliant with ERC721 standard
- Transfer and approval blocking
- Gas-efficient operations

## Contract Architecture

The contract inherits from:
- `ERC721URIStorage`: For storing token metadata
- `Ownable`: For access control

Key components:
- Minting functionality
- Transfer blocking
- Approval blocking
- Metadata generation
- Event emission

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Access to Mandala Chain RPC
- IPFS for storing certificate images

## Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd certificate-nft
```

2. Install dependencies:
```bash
forge install
```

3. Set up environment variables:
```bash
# Create .env file with your configuration
RPC_URL="https://mlg1.mandalachain.io"
PRIVATE_KEY="your-private-key"
```

## Deployment

1. Compile the contract:
```bash
forge build
```

2. Deploy to Mandala Chain:
```bash
forge create src/CertificateNFT.sol:CertificateNFT \
  --rpc-url "https://mlg1.mandalachain.io" \
  --private-key $PRIVATE_KEY \
  --broadcast
```

## Minting Certificates

To mint a new certificate NFT:

```bash
# Export contract address
export NFT_CONTRACT="your-contract-address"

# Mint NFT
cast send $NFT_CONTRACT "mintNFT(address,string)" \
  $RECIPIENT_ADDRESS \
  "https://ipfs.io/ipfs/your-image-hash" \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY
```

## Contract Details

Latest Deployment:
- Network: Mandala Chain
- Contract: 0xcDCf9295EB880C166E73Ef9D42f07eD9c2E1B7Ee
- Explorer: https://niskala.mandalachain.io/address/0xcDCf9295EB880C166E73Ef9D42f07eD9c2E1B7Ee

## Testing

Run the test suite:
```bash
forge test
```

The tests cover:
- Basic minting functionality
- Transfer blocking
- Approval blocking
- Owner-only access

## Security Features

1. Non-transferable tokens
   - All transfer functions are blocked
   - NFTs cannot be moved once minted

2. Access Control
   - Only contract owner can mint certificates
   - All approval functions are blocked

3. Metadata Integrity
   - On-chain metadata storage
   - Base64 encoded JSON structure
   - IPFS integration for immutable storage

