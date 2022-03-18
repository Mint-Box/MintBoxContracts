// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import './CollectionProxy.sol';
import '../ERC721/ERC721MultiCollectionUpgradeable.sol';
import '../MintBoxPool.sol';

contract ERC721MultipleCollectionFactory {

	/// @dev Deployed event
	/// @param proxy proxy contract address
	/// @param owner contract owner
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param root tokens merkle root
	/// @param imp collection implementation contract
	/// @param salt contract creation salt
	/// @param pool mint box contract pool
	/// @param param contract param
	event Deployed(
		CollectionProxy indexed proxy,
		address owner,
		string name,
		string symbol,
		bytes32 root,
		address imp,
		bytes32 salt,
		MintBoxPool pool,
		ERC721MultiCollectionUpgradeable.Param param
	);

	/// @dev deploy contract
	/// @param owner contract owner
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param root tokens merkle root
	/// @param imp collection implementation contract
	/// @param salt contract creation salt
	/// @param pool mint box contract pool
	/// @param param contract param
	/// @return proxy collection proxy contract
	function deploy(
		address owner,
		string memory name,
		string memory symbol,
		bytes32 root,
		address imp,
		bytes32 salt,
		MintBoxPool pool,
		ERC721MultiCollectionUpgradeable.Param memory param
	) external returns (CollectionProxy proxy) {
		bytes memory data = getData(owner, name, symbol, root, pool, param);
		proxy = new CollectionProxy{ salt: salt }(imp, data);

		emit Deployed(proxy, owner, name, symbol, root, imp, salt, pool, param);
	}

	/// @dev get proxy contract initialization data
	/// @param owner contract owner
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param root tokens merkle root
	/// @param param contract param
	/// @param pool mint box contract pool
	/// @return proxy initialization data
	function getData(
		address owner,
		string memory name,
		string memory symbol,
		bytes32 root,
		MintBoxPool pool,
		ERC721MultiCollectionUpgradeable.Param memory param
	) public pure returns (bytes memory) {
		return abi.encodeWithSelector(ERC721MultiCollectionUpgradeable.initialize.selector, owner, name, symbol, root, pool, param);
	}

	/// @dev get ERC721 proxy contract bytecode
	/// @param owner contract owner
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param root tokens merkle root
	/// @param imp collection implementation contract
	/// @param pool mint box contract pool
	/// @param param contract param
	/// @return bytecode
	function getByteCode(
		address owner,
		string memory name,
		string memory symbol,
		bytes32 root,
		address imp,
		MintBoxPool pool,
		ERC721MultiCollectionUpgradeable.Param memory param
	) public pure returns (bytes memory) {
		bytes memory bytecode = type(CollectionProxy).creationCode;
		bytes memory data = getData(owner, name, symbol, root, pool, param);
		return abi.encodePacked(bytecode, abi.encode(imp, data));
	}

	/// @dev calculate contract address
	/// @param owner contract owner
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param root tokens merkle root
	/// @param imp collection implementation contract
	/// @param salt contract creation salt
	/// @param pool mint box contract pool
	/// @param param contract param
	/// @return proxy collection proxy contract
	function getAddress(
		address owner,
		string memory name,
		string memory symbol,
		bytes32 root,
		address imp,
		bytes32 salt,
		MintBoxPool pool,
		ERC721MultiCollectionUpgradeable.Param memory param
	) public view returns (address) {
		bytes32 hash = keccak256(abi.encodePacked(hex'ff', address(this), salt, keccak256(getByteCode(owner, name, symbol, root, imp, pool, param))));
		return address(uint160(uint256(hash)));
	}
}
