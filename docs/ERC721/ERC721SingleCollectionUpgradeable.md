# ERC721SingleCollectionUpgradeable

### initialize

proxy contract initialization

#### Declaration
```
function initialize(address newOwner,string name,string symbol,string uri,address creator,struct CollectionWrapper.Param param) external initializer
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`newOwner` | address | owner of this contract
|`name` | string | contract name
|`symbol` | string | contract symbol
|`uri` | string | default token uri
|`creator` | address | default token creator
|`param` | struct CollectionWrapper.Param | default contract param
### mint

pay the ERC20 token. mint a NFT if the sale is open.

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
|`value` | erc20 token value### addToken

add another token to this contract

#### Declaration
```
function addToken(address creator,string uri) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`creator` | address | token creator
|`uri` | string | token uri
### withdraw

withdraw ERC20 tokens

#### Declaration
```
function withdraw(contract IERC20 to,address amount) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`to` | contract IERC20 | token receiver
|`amount` | address | token value
### tokenURI

get token uri by token id

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
|`amount` | uint256 |  | token value### Withdrawal

> Withdrawal event

#### Params:
| Param | Type | Indexed | Description |
| --- | --- | :---: | --- |
|`payToken` | contract IERC20 | :white_check_mark: | erc20 token address
|`to` | address | :white_check_mark: | token receiver
|`amount` | uint256 |  | token value