pragma solidity ^0.4.25;

contract CrowdFouding{
    
    struct Compain{//companin grama
        address beneficiary;
        uint foudingGoal;
        uint numFounders;
        uint amount;
        mapping (uint=>Founder) founders;
    }
    
    struct Founder{
        address addr;
        uint amount;
    }

    uint companinNum;
    mapping(uint =>Compain) compains;
    function newCompains(address addr,uint goal)  public returns(uint compainId){
        compainId = companinNum++;
        compains[compainId] = Compain(addr,goal,0,0);
        //return compainId;
    }
    function contribute(uint compainId) public payable{
        Compain storage c = compains[compainId];
        c.founders[c.numFounders++] = Founder(msg.sender,msg.value);
        c.amount += msg.value;
    }
    
    function checkGoalReached(uint compainId) public returns (bool reached){
           Compain storage c = compains[compainId];
           if(c.amount<c.foudingGoal)
               return false;
               uint amount =c.amount;
               c.amount = 0;
               c.beneficiary.transfer(amount);
               return true;
          
    }
    
}