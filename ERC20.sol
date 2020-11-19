pragma solidity >0.4.0 <=0.7.0;

contract ERC20{
    
    mapping(address => uint256) balances;
mapping(address => mapping (address => uint256)) allowed;
    
    event Approval(address indexed tokenOwner, address indexed spender,
 uint tokens);
event Transfer(address indexed from, address indexed to,
 uint tokens);
    uint256 totalSupply_;
constructor(uint256 total) public {
   totalSupply_ = total;
   balances[msg.sender] = totalSupply_;
}
function totalSupply() public view returns (uint256) {
  return totalSupply_;
}
function balanceOf(address tokenOwner) public view returns (uint) {
  return balances[tokenOwner];
}
function transfer(address receiver,
                 uint numTokens) public returns (bool) {
  require(numTokens <= balances[msg.sender]);
  balances[msg.sender] = balances[msg.sender] - numTokens;
  balances[receiver] = balances[receiver] + numTokens;
  emit Transfer(msg.sender, receiver, numTokens);
  return true;
}
    function approve(address delegate,
                uint numTokens) public returns (bool) {
  allowed[msg.sender][delegate] = numTokens;
  emit Approval(msg.sender, delegate, numTokens);
  return true;
}function allowance(address owner,
                  address delegate) public view returns (uint) {
  return allowed[owner][delegate];
}
function transferFrom(address owner, address buyer,
                     uint numTokens) public returns (bool) {
                    
  require(numTokens <= balances[owner]);
  require(numTokens <= allowed[owner][msg.sender]);
  balances[owner] = balances[owner] - numTokens;
  allowed[owner][msg.sender] =
        allowed[owner][msg.sender] - numTokens;
  balances[buyer] = balances[buyer] + numTokens;
  Transfer(owner, buyer, numTokens);
  return true;
}
    
}