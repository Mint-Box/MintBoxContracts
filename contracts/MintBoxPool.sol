// SPDX-License-Identifier: UNLICENSE

pragma solidity ^0.8.2;
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';

contract MintBoxPool {
	using SafeERC20 for IERC20;
	using SafeMath for uint256;

	mapping(address => mapping(address => uint256)) public pools;

	event Deposit(IERC20 token, address to, uint256 amount);

	event Withdrawal(IERC20 token, address to, uint256 amount);

	function deposit(IERC20 token, address to, uint256 amount) external {
		token.safeTransferFrom(msg.sender, to, amount);
		pools[address(token)][to] = pools[address(token)][to].add(amount);
	
		emit Deposit(token, to, amount);
	}

	function withdraw(IERC20 token, address to, uint256 amount) external {
		require(pools[address(token)][msg.sender] >= amount, 'Pool: no deposit.');
		pools[address(token)][msg.sender] = pools[address(token)][msg.sender].sub(amount);
		token.safeTransfer(to, amount);
	
		emit Withdrawal(token, to, amount);
	}

}
