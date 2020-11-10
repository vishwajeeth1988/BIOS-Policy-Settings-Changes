# BIOS-Policy-Settings-Changes
Get(All UCS servers) and Set (only M4) BIOS policies according to best practices

All CISCO UCS servers are required to follow the following best practices recommendations for their BIOS policies.

M3:https://www.cisco.com/c/en/us/products/collateral/servers-unified-computing/ucs-c-series-rack-servers/whitepaper_c11-727827.html

M4:https://www.cisco.com/c/en/us/solutions/collateral/data-center-virtualization/unified-computing/whitepaper-c11-737931.html

M5:https://www.cisco.com/c/dam/en/us/products/collateral/servers-unified-computing/ucs-b-series-blade-servers/whitepaper_c11-740098.pdf

The BIOS policies have various parameters that are set to enabled/disabled/platfom-default according to the type of usage of the servers.

GET SCRIPT: With many customers having 1000s of servers distributed among many data centers with many bios policy running on this it can be a hardtask to go back and reset indivdual paramters. This script parses through every parameters of a BIOS policy and exports it to an excel sheet local to the computer running it. The input to this is an excel sheet filled with seed file of all the ucs domains who want to deal with in regards to the BIOS policies and most importantly their parameters.

SET SCRIPT: Its not enough to just get the information, we must also act on it. The Set script does this exactly. For M4 servers, managed by UCS, this script parses all the parameters and set the right parameters to the right setting based on best practice recommendations. This allows the user to avoid having to click the radio button inside these BIOS policies at great risk of human error. Note: The risk is even greater considering that fact that changing the BIOS policy kicks off a reboot in the server (Pending activities based on maintenance policy).

SCOPE of SET script: The scope of the set script is defined to one domain and one policy at a time to localize the affect of the change. This script can be changed to incorporate the M3 and M5 UCS Managed Servers. There are minor changes in BIOS policy parameters when dealing with multiple platforms. 
