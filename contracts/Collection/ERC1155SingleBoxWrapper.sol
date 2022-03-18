// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;
import '@openzeppelin/contracts/utils/math/SafeMath.sol';

contract ERC1155SingleBoxWrapper {
	using SafeMath for uint256;

	struct Token {
		uint256 id;
		uint8 status;
		address creator;
		string uri;
		uint256 supply;
	}

	mapping(uint256 => Token) public tokens;

	uint256 internal current;

	event AddToken(uint256 tokenId, address creator, string uri, uint256 supply);

	event UpdateSupply(uint256 tokenId, uint256 supply);

	event MintToken(address indexed to, uint256 tokenId, uint256 amount);

	/// @dev Explain to a developer any extra details
	/// @param uri the token uri.
	/// @return tokenId  the id of the token.
	function _addToken(
		address creator_,
		string memory uri,
		uint256 supply_
	) internal returns (uint256 tokenId) {
		require(supply_ > 0, 'ERC1155SingleBoxWrapper: invalid creator.');
		require(creator_ != address(0), 'ERC1155SingleBoxWrapper: invalid creator.');
		tokenId = current++;
		tokens[tokenId].creator = creator_;
		tokens[tokenId].uri = uri;
		tokens[tokenId].supply = supply_;

		emit AddToken(tokenId, creator_, uri, supply_);
	}

	function _mintToken(
		address receiver,
		uint256 tokenId,
		uint256 amount
	) internal {
		require(_tokenExists(tokenId), 'ERC1155SingleBoxWrapper: nonexistent token.');
		require(_supply(tokenId) >= amount, 'ERC1155SingleBoxWrapper: supply is not enough.');
		tokens[tokenId].status = 1;
		tokens[tokenId].supply = tokens[tokenId].supply.sub(amount);

		emit MintToken(receiver, tokenId, amount);
	}

	function _updateSupply(uint256 tokenId, uint256 supply_) internal {
		require(_tokenExists(tokenId), 'ERC1155SingleBoxWrapper: nonexistent token.');
		tokens[tokenId].supply = supply_;

		emit UpdateSupply(tokenId, supply_);
	}

	function _tokenURI(uint256 tokenId) internal view returns (string memory) {
		require(_tokenExists(tokenId), 'ERC1155SingleBoxWrapper: nonexistent token.');
		return tokens[tokenId].uri;
	}

	function _creator(uint256 tokenId) internal view returns (address) {
		require(_tokenExists(tokenId), 'ERC1155SingleBoxWrapper: nonexistent token.');
		return tokens[tokenId].creator;
	}

	function _supply(uint256 tokenId) internal view returns (uint256) {
		return tokens[tokenId].supply;
	}

	function _status(uint256 tokenId) internal view returns (uint8) {
		require(_tokenExists(tokenId), 'ERC1155SingleBoxWrapper: nonexistent token.');
		return tokens[tokenId].status;
	}

	function _tokenExists(uint256 tokenId) internal view returns (bool) {
		return tokens[tokenId].creator != address(0);
	}
}
