# ERC721MultiCollectionUpgradeable

### initialize

proxy contract initialization

#### Declaration
```
function initialize(address newOwner,string name,string symbol,bytes32 root,struct CollectionWrapper.Param param) external initializer
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`newOwner` | address | owner of this contract
|`name` | string | contract name
|`symbol` | string | contract symbol
|`root` | bytes32 | tokens merkle root
|`param` | struct CollectionWrapper.Param | default contract param
### claimAndMint

claim and mint the token

#### Declaration
```
function claimAndMint(address to,bytes32 root,string uri,address creator,bytes32[] proofs) external returns (uint256 value)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`to` | address | receiver of the token
|`root` | bytes32 | tokens root
|`uri` | string | token uri
|`creator` | address | token creator
|`proofs` | bytes32[] | token proofs

#### Returns:
| Type | Description |
| --- | --- |
|`value` | erc20 token value### mint

only the nft has been claimed

#### Declaration
```
function mint(address to,uint256 tokenId) external returns (uint256 value)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`to` | address | receiver of the token.
|`tokenId` | uint256 | id of the token.

#### Returns:
| Type | Description |
| --- | --- |
|`value` | erc20 token value### claim

claim the token

#### Declaration
```
function claim(bytes32 root,string uri,address creator,bytes32[] proofs) external returns (uint256 tokenId)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`root` | bytes32 | tokens root
|`uri` | string | token uri
|`creator` | address | token creator
|`proofs` | bytes32[] | token proofs
### addRoot

add tokens with the merkle root

#### Declaration
```
function addRoot(bytes32 root) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`root` | bytes32 | tokens root
### tokenURI

get token uri

#### Declaration
```
function tokenURI(uint256 tokenId) public returns (string)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`tokenId` | uint256 | token id

#### Returns:
| Type | Description |
| --- | --- |
|`token` | uri### withdraw

withdraw ERC20 tokens.

#### Declaration
```
function withdraw(contract IERC20 to,address amount) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`to` | contract IERC20 | receiver of the ERC20 tokens.
|`amount` | address | value of the ERC20 tokens

## Events

### Payment

> Payment event

#### Params:
| Param | Type | Indexed | Description |
| --- | --- | :---: | --- |
|`payToken` | contract IERC20 | :white_check_mark: | pay token
|`from` | address | :white_check_mark: | payer
|`to` | address | :white_check_mark: | token receiver
|`tokenId` | uint256 |  | token id
|`amount` | uint256 |  | token value### Withdrawal

> Withdrawal event

#### Params:
| Param | Type | Indexed | Description |
| --- | --- | :---: | --- |
|`payToken` | contract IERC20 | :white_check_mark: | erc20 token address
|`to` | address | :white_check_mark: | token receiver
|`amount` | uint256 |  | token value