# ERC721MultipleCollectionFactory

### deploy

deploy contract

#### Declaration
```
function deploy(address owner,string name,string symbol,bytes32 root,address imp,address admin,bytes32 salt,struct CollectionWrapper.Param param) external returns (contract CollectionProxy proxy)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`owner` | address | contract owner
|`name` | string | contract name
|`symbol` | string | contract symbol
|`root` | bytes32 | tokens merkle root
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
function getData(address owner,string name,string symbol,bytes32 root,struct CollectionWrapper.Param param) public returns (bytes)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`owner` | address | contract owner
|`name` | string | contract name
|`symbol` | string | contract symbol
|`root` | bytes32 | tokens merkle root
|`param` | struct CollectionWrapper.Param | contract param

#### Returns:
| Type | Description |
| --- | --- |
|`proxy` | initialization data### getByteCode

get ERC721 proxy contract bytecode

#### Declaration
```
function getByteCode(address owner,string name,string symbol,bytes32 root,address imp,address admin,struct CollectionWrapper.Param param) public returns (bytes)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`owner` | address | contract owner
|`name` | string | contract name
|`symbol` | string | contract symbol
|`root` | bytes32 | tokens merkle root
|`imp` | address | collection implementation contract
|`admin` | address | collection proxy contract admin
|`param` | struct CollectionWrapper.Param | contract param

### getAddress

calculate contract address

#### Declaration
```
function getAddress(address owner,string name,string symbol,bytes32 root,address imp,address admin,bytes32 salt,struct CollectionWrapper.Param param) public returns (address)
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`owner` | address | contract owner
|`name` | string | contract name
|`symbol` | string | contract symbol
|`root` | bytes32 | tokens merkle root
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
|`root` | bytes32 |  | tokens merkle root
|`imp` | address |  | collection implementation contract
|`admin` | address |  | collection proxy contract admin
|`salt` | bytes32 |  | contract creation salt
|`param` | struct CollectionWrapper.Param |  | contract param