# ERC1155SingleCollectionFactory

### deploy

deploy contract

#### Declaration
```
function deploy(address owner,string name,string symbol,string uri,address creator,uint256 supply,address imp,address admin,bytes32 salt,struct CollectionWrapper.Param param) external returns (contract CollectionProxy proxy)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`owner` | address | contract owner
|`name` | string | contract name
|`symbol` | string | contract symbol
|`uri` | string | default token uri
|`creator` | address | default token creator
|`supply` | uint256 | default token supply
|`imp` | address | collection implementation contract
|`admin` | address | collection proxy contract admin
|`salt` | bytes32 | contract creation salt
|`param` | struct CollectionWrapper.Param | contract param

#### Returns:
| Type | Description |
| --- | --- |
|`proxy` | collection proxy contract### getData

get proxy contract initialization data

#### Declaration
```
function getData(address owner,string name,string symbol,string uri,address creator,uint256 supply,struct CollectionWrapper.Param param) public returns (bytes)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`owner` | address | contract owner
|`name` | string | contract name
|`symbol` | string | contract symbol
|`uri` | string | default token uri
|`creator` | address | default token creator
|`supply` | uint256 | default token supply
|`param` | struct CollectionWrapper.Param | contract param

#### Returns:
| Type | Description |
| --- | --- |
|`proxy` | initialization data### getByteCode

get proxy contract bytecode

#### Declaration
```
function getByteCode(address owner,string name,string symbol,string uri,address creator,uint256 supply,address imp,address admin,struct CollectionWrapper.Param param) public returns (bytes)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`owner` | address | contract owner
|`name` | string | contract name
|`symbol` | string | contract symbol
|`uri` | string | default token uri
|`creator` | address | default token creator
|`supply` | uint256 | default token supply
|`imp` | address | collection implementation contract
|`admin` | address | collection proxy contract admin
|`param` | struct CollectionWrapper.Param | contract param

### getAddress

calculate contract address

#### Declaration
```
function getAddress(address owner,string name,string symbol,string uri,address creator,uint256 supply,address imp,address admin,bytes32 salt,struct CollectionWrapper.Param param) public returns (address)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`owner` | address | contract owner
|`name` | string | contract name
|`symbol` | string | contract symbol
|`uri` | string | default token uri
|`creator` | address | default token creator
|`supply` | uint256 | default token supply
|`imp` | address | collection implementation contract
|`admin` | address | collection proxy contract admin
|`salt` | bytes32 | contract creation salt
|`param` | struct CollectionWrapper.Param | contract param

#### Returns:
| Type | Description |
| --- | --- |
|`proxy` | collection proxy contract
## Events

### Deployed

> Deployed event

#### Params:
| Param | Type | Indexed | Description |
| --- | --- | :---: | --- |
|`proxy` | contract CollectionProxy | :white_check_mark: | proxy contract address
|`owner` | address |  | contract owner
|`name` | string |  | contract name
|`symbol` | string |  | contract symbol
|`uri` | string |  | default token uri
|`creator` | address |  | default token creator
|`supply` | uint256 |  | default token supply
|`imp` | address |  | collection implementation contract
|`admin` | address |  | collection proxy contract admin
|`salt` | bytes32 |  | contract creation salt
|`param` | struct CollectionWrapper.Param |  | contract param