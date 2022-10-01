//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract HotelRoom{
    enum Status {vacant, Occupied}

    Status public CurrentStatus;

    address payable public Owner;

    event Occupy(address _Occupant, uint256 _Value);

    constructor(){
        CurrentStatus = Status.vacant;
        
        Owner = payable(msg.sender);
    }

    //modifiers
    modifier OnlyWhileVacant{
        require(CurrentStatus == Status.vacant, "Room is Occupied");
        _;
    }
    function BookRoom() payable OnlyWhileVacant public{

        require(msg.value >= 0.5 ether, "Payment incomplete");

        CurrentStatus = Status.Occupied;

        Owner.call{value: msg.value};
       
        emit Occupy(msg.sender, msg.value);
    }
}