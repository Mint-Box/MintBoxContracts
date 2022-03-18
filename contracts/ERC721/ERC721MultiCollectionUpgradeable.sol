// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import './ERC721UpgradeableWrapper.sol';
import '../Collection/CollectionWrapper.sol';
import '../Collection/ERC721MultipleBoxWrapper.sol';

/// @title ERC721MultiCollectionUpgradeable contract,
contract ERC721MultiCollectionUpgradeable is ERC721UpgradeableWrapper, CollectionWrapper, ERC721MultipleBoxWrapper {
	using SafeERC20 for IERC20;

	/// @dev Payment event
	/// @param payToken pay token
	/// @param from payer
	/// @param to token receiver
	/// @param tokenId token id
	/// @param amount token value
	event Payment(IERC20 indexed payToken, address indexed from, address indexed to, uint256 tokenId, uint256 amount);

	constructor() initializer {}

	/// @dev proxy contract initialization
	/// @param newOwner owner of this contract
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param root tokens merkle root
	/// @param param default contract param
	function initialize(
		address newOwner,
		string memory name,
		string memory symbol,
		bytes32 root,
		MintBoxPool pool,
		Param memory param
	) external initializer {
		__ERC721_init(name, symbol);
		_transferOwnership(newOwner);
		_addRoot(root);
		_CollectionWrapper_Init(pool);
		_setParam(param);
	}

	/// @dev claim and mint the token
	/// @param to receiver of the token
	/// @param root tokens root
	/// @param uri token uri
	/// @param creator token creator
	/// @param proofs token proofs
	/// @return value erc20 token value
	function claimAndMint(
		address to,
		bytes32 root,
		string memory uri,
		address creator,
		bytes32[] memory proofs
	) external returns (uint256 value) {
		uint256 tokenId = _claim(root, uri, creator, proofs);
		return _buy(to, tokenId);
	}

	/// @dev only the nft has been claimed
	/// @param to receiver of the token.
	/// @param tokenId id of the token.
	/// @return value erc20 token value
	function mint(address to, uint256 tokenId) external returns (uint256 value) {
		return _buy(to, tokenId);
	}

	function _buy(address to, uint256 tokenId) internal returns (uint256 value) {
		require(isOpen(), 'ERC721MultiCollectionUpgradeable: collection is not open');
		value = valueOf(1);
		IERC20 payToken = payToken();
		if (value > 0) {
			payToken.safeTransferFrom(msg.sender, address(this), value);
		}
		_depositPool(payToken, value);
		_mintToken(to, tokenId);
		_mint(to, tokenId);

		emit Payment(payToken, msg.sender, address(this), tokenId, value);
	}

	/// @dev claim the token
	/// @param root tokens root
	/// @param uri token uri
	/// @param creator token creator
	/// @param proofs token proofs
	function claim(
		bytes32 root,
		string memory uri,
		address creator,
		bytes32[] memory proofs
	) external returns (uint256 tokenId) {
		tokenId = _claim(root, uri, creator, proofs);
	}

	/// @dev add tokens with the merkle root
	/// @param root tokens root
	function addRoot(bytes32 root) external onlyOwner {
		_addRoot(root);
	}

	/// @dev get token uri
	/// @param tokenId token id
	/// @return token uri
	function tokenURI(uint256 tokenId) public view override returns (string memory) {
		require(_exists(tokenId), 'ERC721MultiCollectionUpgradeable: nonexistent token.');
		return _tokenURI(tokenId);
	}

}
