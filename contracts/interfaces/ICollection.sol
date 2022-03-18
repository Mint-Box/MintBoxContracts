// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.2;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

interface ICollection {
	function payToken() external view returns (IERC20);

	function price() external view returns (uint256);

	function valueOf(uint256 amount) external view returns (uint256);

	function close() external view returns (uint256);

	function open() external view returns (uint256);
}
