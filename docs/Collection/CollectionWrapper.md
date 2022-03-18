# CollectionWrapper

### setParam

set the collection info.

#### Declaration
```
function setParam(struct CollectionWrapper.Param _param) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`_param` | struct CollectionWrapper.Param | collection params.
### setContractURI

set the contract uri.

#### Declaration
```
function setContractURI(string contractURI_) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`contractURI_` | string | the contract uri.
### setPayToken

set pay token.

#### Declaration
```
function setPayToken(contract IERC20 payToken_) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`payToken_` | contract IERC20 | pay token.
### setPrice

set price for a NFT.

#### Declaration
```
function setPrice(uint256 price_) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`price_` | uint256 | price of the token.
### setOpen

set the open time

#### Declaration
```
function setOpen(uint64 time) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`time` | uint64 | open time of the contract.
### setClose

set the close time.

#### Declaration
```
function setClose(uint64 time) external onlyOwner
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`time` | uint64 | close time of the contract.
### _setParam

set the collection info.

#### Declaration
```
function _setParam(struct CollectionWrapper.Param _param) internal
```
#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`_param` | struct CollectionWrapper.Param | collection params.

## Events

