// SPDX-License-Identifier: UNLICENSE

pragma solidity ^0.8.2;
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import '@openzeppelin/contracts/utils/Address.sol';

contract DelegatePay {
	using SafeMath for uint256;
	using SafeERC20 for IERC20;
	using Address for address;

	event DelegatePaid(address dest, IERC20 payToken, uint256 amount, bytes data);

	function delegatePay(address dest, IERC20 payToken, uint256 amount, bytes memory data) external returns (bytes memory result) {
		payToken.safeTransferFrom(msg.sender, address(this), amount);
		payToken.safeApprove(dest, amount);
	 	result = dest.functionCall(data);
		(uint256 value) = abi.decode(result, (uint256));
		if (amount > value) {
			payToken.safeTransfer(msg.sender, amount.sub(value));
			payToken.safeApprove(dest, 0);
		}
		emit DelegatePaid(dest, payToken, amount, data);
	}
	
}
