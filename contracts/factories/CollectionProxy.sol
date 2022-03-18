// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import '@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol';

contract CollectionProxy is ERC1967Proxy {
	constructor(
		address imp,
		bytes memory data
	) ERC1967Proxy(imp, data) {
	}
}
