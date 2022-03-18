// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import './CollectionProxy.sol';
import '../ERC1155/ERC1155SingleCollectionUpgradeable.sol';
import '../MintBoxPool.sol';

contract ERC1155SingleCollectionFactory {

	/// @dev Deployed event
	/// @param proxy proxy contract address
	/// @param owner contract owner
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param uri default token uri
	/// @param creator default token creator
	/// @param supply default token supply
	/// @param imp collection implementation contract
	/// @param salt contract creation salt
	/// @param pool mint box contract pool
	/// @param param contract param
	event Deployed(
		CollectionProxy indexed proxy,
		address owner,
		string name,
		string symbol,
		string uri,
		address creator,
		uint256 supply,
		address imp,
		bytes32 salt,
		MintBoxPool pool,
		ERC1155SingleCollectionUpgradeable.Param param
	);

	/// @dev deploy contract
	/// @param owner contract owner
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param uri default token uri
	/// @param creator default token creator
	/// @param supply default token supply
	/// @param imp collection implementation contract
	/// @param salt contract creation salt
	/// @param pool mint box contract pool
	/// @param param contract param
	/// @return proxy collection proxy contract
	function deploy(
		address owner,
		string memory name,
		string memory symbol,
		string memory uri,
		address creator,
		uint256 supply,
		address imp,
		bytes32 salt,
		MintBoxPool pool,
		ERC1155SingleCollectionUpgradeable.Param memory param
	) external returns (CollectionProxy proxy) {
		bytes memory data = getData(owner, name, symbol, uri, creator, supply, pool, param);
		proxy = new CollectionProxy{ salt: salt }(imp, data);

		emit Deployed(proxy, owner, name, symbol, uri, creator, supply, imp, salt, pool, param);
	}

	/// @dev get proxy contract initialization data
	/// @param owner contract owner
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param uri default token uri
	/// @param creator default token creator
	/// @param supply default token supply
	/// @param pool mint box contract pool
	/// @param param contract param
	/// @return proxy initialization data
	function getData(
		address owner,
		string memory name,
		string memory symbol,
		string memory uri,
		address creator,
		uint256 supply,
		MintBoxPool pool,
		ERC1155SingleCollectionUpgradeable.Param memory param
	) public pure returns (bytes memory) {
		return abi.encodeWithSelector(ERC1155SingleCollectionUpgradeable.initialize.selector, owner, name, symbol, uri, creator, supply, pool, param);
	}

	/// @dev get proxy contract bytecode
	/// @param owner contract owner
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param uri default token uri
	/// @param creator default token creator
	/// @param supply default token supply
	/// @param imp collection implementation contract
	/// @param pool mint box contract pool
	/// @param param contract param
	/// @return bytecode
	function getByteCode(
		address owner,
		string memory name,
		string memory symbol,
		string memory uri,
		address creator,
		uint256 supply,
		address imp,
		MintBoxPool pool,
		ERC1155SingleCollectionUpgradeable.Param memory param
	) public pure returns (bytes memory) {
		bytes memory bytecode = type(CollectionProxy).creationCode;
		bytes memory data = getData(owner, name, symbol, uri, creator, supply, pool, param);
		return abi.encodePacked(bytecode, abi.encode(imp, data));
	}

	/// @dev calculate contract address
	/// @param owner contract owner
	/// @param name contract name
	/// @param symbol contract symbol
	/// @param uri default token uri
	/// @param creator default token creator
	/// @param supply default token supply
	/// @param imp collection implementation contract
	/// @param salt contract creation salt
	/// @param pool mint box contract pool
	/// @param param contract param
	/// @return proxy collection proxy contract
	function getAddress(
		address owner,
		string memory name,
		string memory symbol,
		string memory uri,
		address creator,
		uint256 supply,
		address imp,
		bytes32 salt,
		MintBoxPool pool,
		ERC1155SingleCollectionUpgradeable.Param memory param
	) public view returns (address) {
		bytes32 hash = keccak256(
			abi.encodePacked(hex'ff', address(this), salt, keccak256(getByteCode(owner, name, symbol, uri, creator, supply, imp, pool, param)))
		);
		return address(uint160(uint256(hash)));
	}
}
