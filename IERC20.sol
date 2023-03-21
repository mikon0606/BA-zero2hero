// SPDX-License-Identifier: MIT

// Solidity版本声明
pragma solidity ^0.8.4;

// ERC20代币接口定义
interface IERC20 {
    // 转账事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    // 授权事件
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    // 返回总供应量
    function totalSupply() external view returns (uint256);

    // 返回指定地址的代币余额
    function balanceOf(address account) external view returns (uint256);

    // 将代币转账到指定地址
    function transfer(address to, uint256 amount) external returns (bool);

    // 返回允许spender从owner账户中转出的代币数量
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    // 授权给spender从发送者账户转出一定数量的代币
    function approve(address spender, uint256 amount) external returns (bool);

    // 从指定地址转移一定数量的代币到另一个地址
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}
