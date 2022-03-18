// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

contract ERC721SingleBoxWrapper {
	struct Token {
		uint256 id;
		uint8 status;
		address creator;
		string uri;
	}

	mapping(uint256 => Token) public tokens;

	uint256 internal current;

	event AddToken(uint256 tokenId, address creator, string uri);

	event MintToken(address indexed receiver, uint256 tokenId);

	/// @dev Explain to a developer any extra details
	/// @param uri the token uri.
	/// @return tokenId  the id of the token.
	function _addToken(address creator_, string memory uri) internal returns (uint256 tokenId) {
		require(creator_ != address(0), 'ERC721SingleBoxWrapper: invalid creator.');
		tokenId = current++;
		tokens[tokenId].creator = creator_;
		tokens[tokenId].uri = uri;

		emit AddToken(tokenId, creator_, uri);
	}

	function _mintToken(address to, uint256 tokenId) internal {
		require(_tokenExists(tokenId), 'ERC721SingleBoxWrapper: nonexistent token.');
		require(tokens[tokenId].status == 0, 'ERC721SingleBoxWrapper: invalid token status.');
		tokens[tokenId].status = 1;

		emit MintToken(to, tokenId);
	}

	function _tokenURI(uint256 tokenId) internal view returns (string memory) {
		require(_tokenExists(tokenId), 'ERC721SingleBoxWrapper: nonexistent token.');
		return tokens[tokenId].uri;
	}

	function _creator(uint256 tokenId) internal view returns (address) {
		require(_tokenExists(tokenId), 'ERC721SingleBoxWrapper: nonexistent token.');
		return tokens[tokenId].creator;
	}

	function _status(uint256 tokenId) internal view returns (uint8) {
		require(_tokenExists(tokenId), 'ERC721SingleBoxWrapper: nonexistent token.');
		return tokens[tokenId].status;
	}

	function _tokenExists(uint256 tokenId) internal view returns (bool) {
		return tokens[tokenId].creator != address(0);
	}
}
