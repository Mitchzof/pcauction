pragma solidity ^0.4.17;

contract Auction {
  address public owner;
  uint timeout;

  struct Channel {
    address public sender;
    address public receiver;
    uint public deposit;
  }

  mapping (address => Channel) channels;

  function Auction(uint t) {
    owner = msg.sender;
    timeout = now + t;
  }

  function createChannel(uint t, uint d) {
    if (!channels[msg.sender]) {
      Channel memory channel;
      channel.sender = msg.sender;
      channel.receiver = owner;
      channel.deposit = msg.value;

      channels[msg.sender] = channel;
    }
  }

  function bid(uint bid) {
    channel = channels[msg.sender];
    if(now < timeout) {

    }
  }

  function verifyBid() {
  
  }

  function closeChannel(Channel channel) {

  }

  function endAuction(address winner) {
    closeChannel(channels[winner])
    delete channels;
  }

}
