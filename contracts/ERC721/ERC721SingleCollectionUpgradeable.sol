// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import './ERC721UpgradeableWrapper.sol';
import '../Collection/CollectionWrapper.sol';
import '../Collection/ERC721SingleBoxWrapper.sol';

/// @title ERC721SingleCollectionUpgradeable contract
contract ERC721SingleCollectionUpgradeable is ERC721UpgradeableWrapper, CollectionWrapper, ERC721SingleBoxWrapper {
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
	/// @param uri default token uri
	/// @param creator default token creator
	/// @param pool mint box contract pool
	/// @param param default contract param
	function initialize(
		address newOwner,
		string memory name,
		string memory symbol,
		string memory uri,
		address creator,
		MintBoxPool pool,
		Param memory param
	) external initializer {
		__ERC721_init(name, symbol);
		_transferOwnership(newOwner);
		_addToken(creator, uri);
		_CollectionWrapper_Init(pool);
		_setParam(param);
	}

	/// @dev pay the ERC20 token. mint a NFT if the sale is open.
	/// @param to receiver of the token.
	/// @param tokenId id of the token.
	/// @return value erc20 token value
	function mint(address to, uint256 tokenId) external returns (uint256 value) {
		require(isOpen(), 'ERC721SingleCollectionUpgradeable: collection is not open');
		value = valueOf(1);
		IERC20 payToken = payToken();
		if (value > 0) {
			payToken.safeTransferFrom(msg.sender, address(this), value);
			_depositPool(payToken, value);
		}
		_mintToken(to, tokenId);
		_safeMint(to, tokenId);
		emit Payment(payToken, msg.sender, address(this), tokenId, value);
	}

	/// @dev add another token to this contract
	/// @param creator token creator
	/// @param uri token uri
	function addToken(address creator, string memory uri) external onlyOwner {
		_addToken(creator, uri);
	}

	/// @dev get token uri by token id
	/// @param tokenId token id
	/// @return token uri
	function tokenURI(uint256 tokenId) public view override returns (string memory) {
		require(_exists(tokenId), 'ERC721SingleCollectionUpgradeable: nonexistent token.');
		return _tokenURI(tokenId);
	}
}
