# ERC1155SingleCollectionUpgradeable

### initialize

proxy contract initialization

#### Declaration
```
function initialize(address newOwner,string name,string symbol,string _uri,address creator,uint256 supply,struct CollectionWrapper.Param param) external initializer
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`newOwner` | address | owner of this contract
|`name` | string | contract name
|`symbol` | string | contract symbol
|`_uri` | string | default token uri
|`creator` | address | default token creator
|`supply` | uint256 | default token supply
|`param` | struct CollectionWrapper.Param | default contract param
### mint

pay the ERC20 token. mint a NFT to an address if the sale is open.

#### Declaration
```
function mint(address to,uint256 tokenId,uint256 amount,bytes data) external returns (uint256 value)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`to` | address | token receiver
|`tokenId` | uint256 | token id
|`amount` | uint256 | token amount
|`data` | bytes | call data

#### Returns:
| Type | Description |
| --- | --- |
|`value` | erc20 token value### addToken

add a token for minting.
#### Declaration
```
function addToken() external onlyOwner
```

### updateSupply

update a token supply.

#### Declaration
```
function updateSupply(uint256 tokenId,uint256 supply) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`tokenId` | uint256 | token id.
|`supply` | uint256 | token supply.
### withdraw

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
### uri

get token uri by token id

#### Declaration
```
function uri(uint256 tokenId) public returns (string)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`tokenId` | uint256 | token id

#### Returns:
| Type | Description |
| --- | --- |
|`token` | uri
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
|`amount` | uint256 |  | token amount
|`value` | uint256 |  | token value### Withdrawal

> Withdrawal event

#### Params:
| Param | Type | Indexed | Description |
| --- | --- | :---: | --- |
|`payToken` | contract IERC20 | :white_check_mark: | erc20 token address
|`to` | address | :white_check_mark: | token receiver
|`amount` | uint256 |  | token value