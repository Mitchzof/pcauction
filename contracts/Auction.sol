pragma solidity ^0.4.17;

contract Auction {
  address public owner;
  uint timeout;

  struct Channel {
    address sender;
    address receiver;
    uint deposit;
    uint timeout;
  }

  mapping (address => Channel) channels;

  // Constructor
  function Auction(uint t) {
    owner = msg.sender;
    timeout = now + t;
  }

  // Allows contract owner to begin a new auction if timeout is passed
  function reset(uint t) {
    require(msg.sender == owner && now >= timeout);
    timeout = t;
  }

  // Allows a user to create a new payment channel
  function createChannel(uint d) {
    require(channels[msg.sender].deposit != 0 && msg.value > 0 && timeout != 0);

    Channel memory channel;
    channel.sender = msg.sender;
    channel.receiver = owner;
    channel.deposit = msg.value;
    channel.timeout = timeout;

    channels[msg.sender] = channel;
  }

  // Allows a user to close their channel
  function closeChannel() {
    require(channels[msg.sender].deposit != 0 && now >= channels[msg.sender].timeout);

    if (!msg.sender.send(channels[msg.sender].deposit)) throw;
    delete channels[msg.sender];
  }

  // Allows the contract owner to recover funds from a winning contract
  function endAuction(bytes32 hash, uint8 v, bytes32 r, bytes32 s, uint value) {
    require(now >= timeout && msg.sender == owner);

    address signer;
    bytes32 proof;

    signer = ecrecover(hash, v, r, s);
    if (channels[msg.sender].deposit != 0) throw;

    proof = sha3(channels[signer], value);
    if (proof != hash || timeout != channels[signer].timeout || value > channels[signer].deposit) throw;

    //TODO - Learn more about EC cryptography & complete proof/signer recovery

    if (!owner.send(value) || !signer.send(channels[signer].deposit - value)) throw;
    timeout = 0;
  }
}
