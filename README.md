# pcauction

I'll add more to this readme later, though I'll explain a bit about the project.

This contract aims to enable instant bidding in forward auctions on the Ethereum network, 
through the use of multiple payment channels between auctioneer and bidder.

Some centralization is involved, though ultimately funds are secured to an extent.

The only elements of trust involved are as follows:

That the auctioneer chooses the proper winner, as the highest bidder cannot 
be stored in the contract without crippling latency.

That the auctioneer will give the reward, though this can be adapted for anything on-chain
ex. ERC721 or ERC20 tokens.

To use the contract, the auctioneer must effectively keep track of highest bids,
and manage signatures sent with payments.
