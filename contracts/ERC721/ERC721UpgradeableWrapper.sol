// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import '@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol';

contract ERC721UpgradeableWrapper is ERC721EnumerableUpgradeable, ERC721BurnableUpgradeable {
	bytes4 internal contractURIInterfaceId = bytes4(keccak256('contractURI()'));

	function _beforeTokenTransfer(
		address from,
		address to,
		uint256 tokenId
	) internal override(ERC721EnumerableUpgradeable, ERC721Upgradeable) {
		super._beforeTokenTransfer(from, to, tokenId);
	}

	function supportsInterface(bytes4 interfaceId) public view override(ERC721EnumerableUpgradeable, ERC721Upgradeable) returns (bool) {
		return super.supportsInterface(interfaceId) || interfaceId == contractURIInterfaceId;
	}
}
