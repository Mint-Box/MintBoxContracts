// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol';
import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

import '../interfaces/ICollection.sol';
import '../MintBoxPool.sol';

abstract contract CollectionWrapper is ICollection, OwnableUpgradeable {
	using SafeMathUpgradeable for uint256;
	using SafeERC20 for IERC20;

	struct Param {
		IERC20 payToken;
		uint256 price;
		uint64 open;
		uint64 close;
		string uri;
	}

	MintBoxPool public pool;

	Param public param;

	event SetParam(Param param);

	event SetContractURI(string uri);

	event SetPayToken(IERC20 payToken);

	event SetPrice(uint256 price);

	event SetOpen(uint64 time);

	event SetClose(uint64 time);

	function _CollectionWrapper_Init(MintBoxPool pool_) internal {
		pool = pool_;
	}

	function _depositPool(IERC20 payToken_, uint256 value) internal {
		payToken_.safeApprove(address(pool), value);
		pool.deposit(payToken_, owner(), value);
		payToken_.safeApprove(address(pool), 0);
	}

	/// @dev set the collection info.
	/// @param _param collection params.
	function setParam(Param memory _param) external onlyOwner {
		_setParam(_param);
	}

	/// @dev set the contract uri.
	/// @param contractURI_ the contract uri.
	function setContractURI(string memory contractURI_) external onlyOwner {
		_setContractURI(contractURI_);
	}

	/// @dev set pay token.
	/// @param payToken_ pay token.
	function setPayToken(IERC20 payToken_) external onlyOwner {
		_setPayToken(payToken_);
	}

	/// @dev set price for a NFT.
	/// @param price_ price of the token.
	function setPrice(uint256 price_) external onlyOwner {
		_setPrice(price_);
	}

	/// @dev set the open time
	/// @param time open time of the contract.
	function setOpen(uint64 time) external onlyOwner {
		if (close() > 0) {
			require(time <= close(), 'CollectionWrapper: Invalid time.');
		}
		_setOpen(time);
	}

	/// @dev set the close time.
	/// @param time close time of the contract.
	function setClose(uint64 time) external onlyOwner {
		require(time >= open(), 'CollectionWrapper: Invalid time.');
		_setClose(time);
	}

	function valueOf(uint256 amount) public view override returns (uint256) {
		return price().mul(amount);
	}

	function payToken() public view override returns (IERC20) {
		return param.payToken;
	}

	function price() public view override returns (uint256) {
		return param.price;
	}

	function close() public view override returns (uint256) {
		return param.close;
	}

	function open() public view override returns (uint256) {
		return param.open;
	}

	function isNeverClosed() public view returns (bool) {
		return param.close == 0;
	}

	function isOpen() public view returns (bool) {
		if (isNeverClosed()) {
			return block.timestamp > param.open;
		}
		return block.timestamp >= param.open && block.timestamp <= param.close;
	}

	function isLimited() public view returns (bool) {
		return param.open > 0 && param.close > 0 && param.close > param.open;
	}

	function timestamp() public view returns (uint256) {
		return block.timestamp;
	}

	function isClosed() public view returns (bool) {
		if (isNeverClosed()) {
			return false;
		}
		return block.timestamp > param.close;
	}

	/// @dev set the collection info.
	/// @param _param collection params.
	function _setParam(Param memory _param) internal {
		param = _param;
		emit SetParam(_param);
	}

	function _setPayToken(IERC20 payToken_) internal {
		param.payToken = payToken_;

		emit SetPayToken(payToken_);
	}

	function _setPrice(uint256 price_) internal {
		param.price = price_;
		emit SetPrice(price_);
	}

	function _setOpen(uint64 time) internal {
		if (param.close > 0) {
			require(time <= param.close, 'CollectionWrapper: Invalid time.');
		}
		param.open = time;

		emit SetOpen(time);
	}

	function _setClose(uint64 time) internal {
		require(time >= param.open, 'CollectionWrapper: Invalid time.');
		param.close = time;

		emit SetClose(time);
	}

	function _setContractURI(string memory contractURI_) internal {
		param.uri = contractURI_;

		emit SetContractURI(contractURI_);
	}
}
