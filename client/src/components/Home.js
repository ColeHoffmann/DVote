import React, { Component } from "react";
import getWeb3 from "../getWeb3";
import VotingContract from "../contracts/VotingContract.json";
import NavigationAdmin from '.NavigationAdmin';
import Navigation from '.Navigation';


class Home extends Component {
  state = {
           VotingInstance: undefined,
           web3: null,
           accounts: null,
           isOwner: false 
          };

  componentDidMount = async () => {

    if(!window.location.hash){
      window.location = window.location + '#loaded';
      window.location.reload();
      }

    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();

      // Get the contract instance.
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = VotingContract.networks[networkId];
      const instance = new web3.eth.Contract(
        VotingContract.abi,
        deployedNetwork && deployedNetwork.address,
      );

      this.setState({VotingInstance: instance, web3: web3, account: accounts[0] }); 
      const owner = await this.state.VotingInstance.methods.getOwner().call();
        if(this.setState.account === owner){
          this.setState({isOwner : true});
        }
        
      let start = await this.state.VotingInstance.methods.getStart().call();
      let end = await this.state.VotingInstance.methods.getEnd().call();


      this.setState({ start : start, end : end });
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  runExample = async () => {
    const { accounts, contract } = this.state;

    // Stores a given value, 5 by default.
    await contract.methods.set(5).send({ from: accounts[0] });

    // Get the value from the contract to prove it worked.
    const response = await contract.methods.get().call();

    // Update state with the result.
    this.setState({ storageValue: response });
  };


  render() {
    if (!this.state.web3) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }
    return (
      <div className="App">
        {/* <div>{this.state.owner}</div> */}
        {/* <p>Account address - {this.state.account}</p> */}
        <div className="CandidateDetails">
          <div className="CandidateDetails-title">
            <h1>
              ADMIN PORTAL
            </h1>
          </div>
        </div>
        {this.state.isOwner ? <NavigationAdmin /> : <Navigation />}

        <div className = "home">
             Welcome to DVote. A Decentralized voting app built on the Ethereum blockchain.
        </div>
      
      </div>
    );
  }
}


export default Home;
