// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract LiquidityMining {
    using SafeERC20 for IERC20;

    // 不可变的代币地址和每小时奖励数量
    IERC20 public immutable token;
    uint256 public immutable rewardsPerHour = 1000; // 0.01%

    // 用户的余额和上次更新时间，总质押量
    mapping(address => uint256) public balanceOf;
    mapping(address => uint256) public lastUpdated;
    uint256 public totalStaked = 0;

    // 抵押事件
    event Deposit(address address_, uint256 amount_);

    constructor(IERC20 token_) {
        token = token_;
    }

    // 查询总奖励
    function totalRewards() external view returns (uint256) {
        return _totalRewards();
    }

    // 计算总奖励
    function _totalRewards() internal view returns (uint256) {
        return token.balanceOf(address(this)) - totalStaked;
    }

    // 用户抵押代币
    function deposit(uint256 amount_) external {
        token.safeTransferFrom(msg.sender, address(this), amount_);
        balanceOf[msg.sender] += amount_;
        lastUpdated[msg.sender] = block.timestamp;
        totalStaked += amount_;
        emit Deposit(msg.sender, amount_);
    }

    // 查询用户奖励
    function rewards(address address_) external view returns (uint256) {
        return _rewards(address_);
    }

    // 计算用户奖励
    function _rewards(address address_) internal view returns (uint256) {
        return
            ((block.timestamp - lastUpdated[address_]) * balanceOf[address_]) /
            (rewardsPerHour * 1 hours);
    }

    // 用户领取奖励
    function claim() external {
        uint256 amount = _rewards(msg.sender);
        token.safeTransfer(msg.sender, amount);
    }
}
