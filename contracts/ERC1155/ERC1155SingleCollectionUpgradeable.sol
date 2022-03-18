// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';

import './ERC1155UpgradeableWrapper.sol';
import '../Collection/CollectionWrapper.sol';
import '../Collection/ERC1155SingleBoxWrapper.sol';

/// @title ERC1155SingleCollectionUpgradeable contract
contract ERC1155SingleCollectionUpgradeable is ERC1155UpgradeableWrapper, CollectionWrapper, ERC1155SingleBoxWrapper {
	using SafeERC20 for IERC20;

	/// @dev Payment event
	/// @param payToken pay token
	/// @param from payer
	/// @param to token receiver
	/// @param tokenId token id
	/// @param amount token amount
	/// @param value token value
	event Payment(IERC20 indexed payToken, address indexed from, address indexed to, uint256 tokenId, uint256 amount, uint256 value);

	constructor() initializer {}

	/// @dev proxy contract initialization
	/// @param newOwner owner of this contract
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param _uri default token uri
	/// @param creator default token creator
	/// @param supply default token supply
	/// @param pool mint box contract pool
	/// @param param default contract param
	function initialize(
		address newOwner,
		string memory name,
		string memory symbol,
		string memory _uri,
		address creator,
		uint256 supply,
		MintBoxPool pool,
		Param memory param
	) external initializer {
		__Init_ERC1155(param.uri, name, symbol);
		_transferOwnership(newOwner);
		_setParam(param);
		_CollectionWrapper_Init(pool);
		_addToken(creator, _uri, supply);
	}

	/// @dev pay the ERC20 token. mint a NFT to an address if the sale is open.
	/// @param to token receiver
	/// @param tokenId token id
	/// @param amount token amount
	/// @param data call data
	/// @return value erc20 token value
	function mint(
		address to,
		uint256 tokenId,
		uint256 amount,
		bytes memory data
	) external returns (uint256 value) {
		require(isOpen(), 'ERC1155SingleCollectionUpgradeable: collection is not open');
		IERC20 payToken = payToken();
		value = valueOf(amount);
		if (value > 0) {
			payToken.safeTransferFrom(msg.sender, address(this), value);
		}
		_depositPool(payToken, value);
		_mintToken(to, tokenId, amount);
		_mint(to, tokenId, amount, data);
		emit Payment(payToken, msg.sender, address(this), tokenId, amount, value);
	}

	/// @dev add a token for minting.
	function addToken(
		address creator,
		string memory uri_,
		uint256 supply
	) external onlyOwner {
		_addToken(creator, uri_, supply);
	}

	/// @dev update a token supply.
	/// @param tokenId token id.
	/// @param supply token supply.
	function updateSupply(uint256 tokenId, uint256 supply) external onlyOwner {
		_updateSupply(tokenId, supply);
	}

	/// @dev get token uri by token id
	/// @param tokenId token id
	/// @return token uri
	function uri(uint256 tokenId) public view override returns (string memory) {
		require(exists(tokenId), 'ERC1155SingleCollectionUpgradeable: nonexistent token.');
		return _tokenURI(tokenId);
	}
}
