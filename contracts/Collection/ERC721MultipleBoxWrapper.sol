// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import '@openzeppelin/contracts/utils/cryptography/MerkleProof.sol';

contract ERC721MultipleBoxWrapper {
	struct Token {
		address creator;
		string uri;
		uint8 status; // 0 initialized, 1 claimed, 2 minted.
	}

	mapping(uint256 => Token) public tokens;

	mapping(bytes32 => uint256) public tokenIds;

	mapping(bytes32 => bool) internal roots;

	uint256 internal current;

	event AddRoot(bytes32 indexed root);

	event ClaimToken(uint256 tokenId, bytes32 root, bytes32[] proofs, address creator, string uri);

	event MintToken(address indexed to, uint256 tokenId);

	function _addRoot(bytes32 root) internal {
		require(!rootExists(root), 'ERC721MultipleBoxWrapper: root exists.');
		roots[root] = true;

		emit AddRoot(root);
	}

	function rootExists(bytes32 root) public view returns (bool) {
		return roots[root];
	}

	function _tokenURI(uint256 tokenId) internal view returns (string memory) {
		return tokens[tokenId].uri;
	}

	function _creator(uint256 tokenId) internal view returns (address) {
		return tokens[tokenId].creator;
	}

	function _status(uint256 tokenId) internal view returns (uint8) {
		return tokens[tokenId].status;
	}

	function isValid(
		bytes32 root,
		bytes32[] memory proofs,
		address creator_,
		string memory uri
	) public view onlyRootExists(root) returns (bool) {
		bytes32 node = keccak256(abi.encodePacked(creator_, uri));
		return MerkleProof.verify(proofs, root, node);
	}

	function isClaimed(bytes32 key_) public view returns (bool) {
		uint256 tokenId = tokenIds[key_];
		return tokens[tokenId].status > 0;
	}

	function isMinted(bytes32 key_) public view returns (bool) {
		uint256 tokenId = tokenIds[key_];
		return tokens[tokenId].status == 2;
	}

	function key(
		bytes32 root,
		bytes32[] memory proofs,
		address creator_,
		string memory uri
	) public pure returns (bytes32) {
		return keccak256(abi.encodePacked(root, proofs, creator_, uri));
	}

	function _mintToken(address to, uint256 tokenId) internal {
		require(tokens[tokenId].status == 1, 'ERC721MultipleBoxWrapper: invalid token status.');
		tokens[tokenId].status = 2;

		emit MintToken(to, tokenId);
	}

	function _claim(
		bytes32 root,
		string memory uri,
		address creator,
		bytes32[] memory proofs
	) internal onlyRootExists(root) returns (uint256 tokenId) {
		require(creator != address(0), 'ERC721MultipleBoxWrapper: invalid creator.');
		require(isValid(root, proofs, creator, uri), 'ERC721MultipleBoxWrapper: invalid proofs.');
		bytes32 key_ = key(root, proofs, creator, uri);
		require(!isClaimed(key_), 'ERC721MultipleBoxWrapper: token is claimed.');
		tokenId = ++current;
		tokens[tokenId].uri = uri;
		tokens[tokenId].creator = creator;
		tokens[tokenId].status = 1;
		tokenIds[key_] = tokenId;

		emit ClaimToken(tokenId, root, proofs, creator, uri);
	}

	modifier onlyRootExists(bytes32 root) {
		require(rootExists(root), 'ERC721MultipleBoxWrapper: nonexistent root.');
		_;
	}
}
