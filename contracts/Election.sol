// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Election{

    address public admin;
    uint voterCount;
    uint candidateCount;
    bool start;
    bool end;
              constructor(){

                  admin=msg.sender;
                  voterCount=0;
                  candidateCount=0;
                  start=false;
                  end=false;
              }
              modifier onlyAdmin(){
                     require(msg.sender==admin,"Not admin");
                     _;
              }
                  //adding a candidate.
              struct candidate{
                  string header;
                  string slogan;
                  uint voteCount;
                  uint candidateId; 
              }

              mapping(uint256=>candidate) candiateDetails;

              function addCandidate(string memory _header, string memory _slogan) public onlyAdmin{

                  candidate memory newCandidate = candidate({candidateId : candidateCount,header : _header,
                                                             slogan : _slogan,voteCount:0});
 
                             candiateDetails[candidateCount]=newCandidate;
                             candidateCount += 1;
                                    }                   

           //modelling election details
          
          struct ElectionDetails{

              string adminName;
              string adminEmail;
              string adminTitle;
              string electionTitle;
              string organizationTitle;                  
          }

          ElectionDetails electionDetails;
          
          function setElectionDetails(

              string memory _adminName,
              string memory _adminEmail,
              string memory _adminTitle,
              string memory _electionTitle,
              string memory _organizationTitle
          ) public onlyAdmin{

              electionDetails = ElectionDetails(_adminName, _adminEmail, _adminTitle, _electionTitle, _organizationTitle);
              start = true;
              end= false;
          }

           function getElectionDetails() public view returns( 

                  string memory adminName,
                  string memory adminEmail,
                  string memory adminTitle,
                  string memory electionTitle,
                  string memory organizationTitle){

                      return(
                          electionDetails.adminName,
                          electionDetails.adminEmail,
                          electionDetails.adminTitle,
                          electionDetails.electionTitle,
                          electionDetails.organizationTitle
                      );       

           }

            function getTotalCandidates() public view returns(uint256){
                         return candidateCount;

                      }

            function getTotalVoters() public view returns(uint256){

                return voterCount;
            }
            //modelling voter
            
            struct Voter{
                             
                             string name;
                             address voterAddress;
                             string phoneNumber;
                             bool isVerified;
                             bool hasVoted;
                             bool hasRegistered;
                             
            }
            address[] public Voters;
            mapping(address=>Voter) voterDetails;

            //request to be added as a voter;
            
            function registerAsVoter(string memory _name, string memory _phoneNumber) public {
                Voter memory newVoter=Voter({

                                            voterAddress:msg.sender,
                                             name:_name,
                                             phoneNumber:_phoneNumber,
                                             hasVoted:false,
                                             hasRegistered:true,
                                             isVerified:false

                });
                voterDetails[msg.sender]= newVoter;
                Voters.push(msg.sender);
                voterCount+=1;
            }

            //verifyVoter by admin
            function verifyVoter(bool _verifiedStatus, address voterAddress) public onlyAdmin{

                voterDetails[voterAddress].isVerified=_verifiedStatus;
            }
   
           //VOTING Function

           function vote(uint candidateId) public{
               require(voterDetails[msg.sender].isVerified==true);
               require(voterDetails[msg.sender].hasVoted==false);
               require(start==true);
               require(end==false);
            candiateDetails[candidateId].voteCount+=1;
                voterDetails[msg.sender].hasVoted==true;
           } 

           function endElection() public onlyAdmin{
               end=true;
               start=false;
           }
            function Start() public view returns(bool){
                return start;
            }
            function End() public view returns(bool){
                return end;
            }

}

