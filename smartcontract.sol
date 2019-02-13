pragma solidity ^0.5.0;

contract CryptoPass {

    mapping (address => string) keyUserName;   // mapping of pubKey : "univ-username"
    //mapping (string => bool) isTaken;          // mapping of "univ-username" : {true - taken, false - free}
    string[] public usedUname;


    // start adding address in array

    uint public flag = 2;
    event sameName(bool val);

    function setValue(address _pubKey, string memory _userName) public {

        usedUname.push('Trial');

        uint arrayLength = usedUname.length;

        for (uint i=0; i<arrayLength; i++) {
              // do something
            if(stringsEqual(usedUname[i],_userName)){

                flag=1;
                //emit sameName(true);              // emit event if univ-username is NOT unique
                //Flag = 1 means error
                break;
            }
            else
                flag=0;

        }
        if (flag==0) {
            usedUname.push(_userName);
            keyUserName[_pubKey] = _userName;

            //emit sameName(false);  //Flag = 0 means no error
        }
    }

    function getValue(address _pubKey) public view returns (string memory) {
        loginReq(_pubKey);
        return (keyUserName[_pubKey]);
    }

    function getFlag() public view returns (uint) {
        return flag;
    }

    function loginReq(address _pubKey) internal view returns (bool) {

        // return true if user doesn't already have an account, redirect to Register page
        if(keccak256(abi.encodePacked(keyUserName[_pubKey])) == keccak256(abi.encodePacked("")))
            return true;
        else
            return false;
    }



    function stringsEqual(string storage _a, string memory _b) internal view returns (bool) {
        bytes storage a = bytes(_a);
        bytes memory b = bytes(_b);

        // Compare two strings quickly by length to try to avoid detailed loop comparison
        if (a.length != b.length)
            return false;

        // Compare two strings in detail Bit-by-Bit
        for (uint i = 0; i < a.length; i++)
            if (a[i] != b[i])
                return false;

        // Byte values of string are the same
        return true;
    }
}
