// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import '@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155BurnableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol';

abstract contract ERC1155UpgradeableWrapper is ERC1155BurnableUpgradeable, ERC1155SupplyUpgradeable {
	bytes4 internal contractURIInterfaceId = bytes4(keccak256('contractURI()'));

	string internal _name;
	string internal _symbol;

	function __Init_ERC1155(
		string memory uri,
		string memory name_,
		string memory symbol_
	) internal onlyInitializing {
		__ERC1155_init(uri);
		_name = name_;
		_symbol = symbol_;
	}

	function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
		return super.supportsInterface(interfaceId) || interfaceId == contractURIInterfaceId;
	}

	function name() public view returns (string memory) {
		return _name;
	}

	function symbol() public view returns (string memory) {
		return _symbol;
	}

	function _beforeTokenTransfer(
		address operator,
		address from,
		address to,
		uint256[] memory ids,
		uint256[] memory amounts,
		bytes memory data
	) internal virtual override(ERC1155Upgradeable, ERC1155SupplyUpgradeable) {
		super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
	}
}
