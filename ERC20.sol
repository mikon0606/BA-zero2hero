// SPDX-License-Identifier: MIT

// Solidity版本声明
pragma solidity ^0.8.4;

// 导入ERC20接口
import "./IERC20.sol";

// ERC20合约定义
contract ERC20 is IERC20 {
    // 储存所有地址的余额
    mapping(address => uint256) public override balanceOf;

    // 储存所有地址授权给其他地址的转账限额
    mapping(address => mapping(address => uint256)) public override allowance;

    // 总供应量
    uint256 public override totalSupply;

    // 代币名称，符号，小数位数
    string public name;
    string public symbol;
    uint8 public decimals = 18;

    // 构造函数，接受代币名称和符号作为参数
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    // 转账函数
    function transfer(
        address recipient,
        uint amount
    ) external override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // 授权函数
    function approve(
        address spender,
        uint amount
    ) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // 从发送者地址转移一定数量代币到接收者地址
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    // 发行新代币
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    // 销毁代币
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(address(0), msg.sender, amount);
    }
}
