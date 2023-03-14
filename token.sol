pragma solidity ^0.8.0;

// interface ERC20 {
//     function totalSupply() external view returns (uint256);
//     function balanceOf(address owner) external view returns (uint256);
//     function transfer(address recipient, uint256 amount) external returns (bool);
//     function approve(address spender, uint256 amount) external returns (bool);
//     function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
//     function allowance(address owner, address spender) external view returns (uint256);

//     function name() external view returns (string memory);
//     function symbol() external view returns (string memory);
//     function decimals() external view returns (uint8) ;

//     event Transfer(address indexed from, address indexed to, uint256 value);
//     event Approval(address indexed owner, address indexed spender, uint256 value);
// }

contract Token {
    // Total supply of tokens
    uint256 public totalSupply;

    // Mapping from address to balance
    mapping(address => uint256) public balanceOf;

    // Mapping from address to approved amount for transfer
    mapping(address => mapping(address => uint256)) public allowed;

    // Event for token transfer
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Event for token approval
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Token name
    string public constant name = "Example Token";

    // Token symbol
    string public constant symbol = "ex";

    // Number of decimal places for tokens
    uint8 public constant decimals = 18;

    // Initialize the contract with a total supply of tokens
    constructor() public {
        totalSupply = 1000000000 * (10 ** uint256(decimals)); // 1 billion tokens
        balanceOf[msg.sender] = totalSupply;
    }

    // Function to mint new tokens
    function mint(uint256 amount) public {
        require(msg.sender == address(this)); // Only the contract owner can mint new tokens
        totalSupply += amount;
        balanceOf[msg.sender] += amount;
    }

    // Function to burn tokens
    function burn(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount);
        totalSupply -= amount;
        balanceOf[msg.sender] -= amount;
    }

    // Function to transfer tokens
    function transfer(address to, uint256 value) public returns (bool) {
        require(balanceOf[msg.sender] >= value);
        require(to != address(0));

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);

        return true;
    }

    // Function to approve tokens for transfer
    function approve(address spender, uint256 value) public returns (bool) {
        allowed[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);

        return true;
    }
}