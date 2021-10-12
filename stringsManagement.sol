//SPDX-License-Identifier: MIT
pragma solidity ^0.4.14;

import "github.com/Arachnid/solidity-stringutils/src/strings.sol";

contract Contract {                                                            
    using strings for *;    
    string[5] public parts1;
    string[5] public parts2;


    function smt() public  {                                               
        strings.slice memory s = "This-Is-A-Problem".toSlice();                
        strings.slice memory delim = "-".toSlice();                            
        string[] memory parts = new string[](s.count(delim)+1);                  
        for (uint i = 0; i < parts.length; i++) {                              
           parts[i] = s.split(delim).toString();   
           parts1[i] = parts[i];
        }                                                                      
    }   
    
    function smt2() public  {                                               
        strings.slice memory s = '["finished",2,1]'.toSlice(); 
        s.beyond("[".toSlice()).until("]".toSlice());
        strings.slice memory delim = ",".toSlice();  
        
        string[] memory parts = new string[](s.count(delim)+1);    
        for (uint i = 0; i < parts.length; i++) {                              
           parts[i] = s.split(delim).toString();   
           parts2[i] = parts[i];
        }
        
    }   
    
    function stringToUint(string s) constant returns (uint) {
        bytes memory b = bytes(s);
        uint result = 0;
        for (uint i = 0; i < b.length; i++) { 
            if (b[i] >= 48 && b[i] <= 57) {
                result = result * 10 + (uint(b[i]) - 48); 
            }
        }
    return result; 
}
    
