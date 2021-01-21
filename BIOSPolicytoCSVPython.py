import csv
import json
import requests
import pandas as pd
from intersight_auth import IntersightAuth

#Creating Authorization
#

AUTH = IntersightAuth(
        secret_key_filename='SecretKey.txt', #insert secret key as a file with the name SecretKey.txt
        api_key_id= '5df2c79d7564612d30bb2223/5df2c7877564612d30bb1893/5ecedcef7564612d30eebadf' #insert API reference.
        )


if __name__=="__main__":

#intersight Get commands for the BIOS policy
        get_bios_policy = {
            "request_method":"GET",
            "resource_path": (
                'https://www.intersight.com/api/v1/bios/Policies'+
                '?$select=Description,Name,ProcessorC1e,ProcessorC3report,ProcessorC6report,ProcessorCstate,IntelTurboBoostTech,EnhancedIntelSpeedStepTech,IntelHyperThreadingTech,IntelVirtualizationTechnology,DirectCacheAccess,CpuPerformance,IntelVtForDirectedIo,SelectMemoryRasConfiguration')
        }

        responseget = requests.request(
            method=get_bios_policy['request_method'],
            url=get_bios_policy['resource_path'],
            auth= AUTH
        )
        
        post_bios_policy = {
        "request_method":"POST",
        "resource_path":"https://www.intersight.com/api/v1/bios/Policies/"+ #moid_entered_by_user -> this is the MOID of the policy you want to change.
                           json.loads(responseget.text)['Results'][0]['Moid'],
            "request_body": {"ProcessorCstate": "disabled",
                              "ProcessorC1e":"disbaled",
                              "ProcessorC3report":"disabled",
                              "ProcessorC6report":"disabled",
                              "ProcessorCstate":"disabled"  }
            }
           
        responsepost = requests.request(
           method=post_bios_policy['request_method'],
           url=post_bios_policy['resource_path'],
           data=json.dumps(post_bios_policy['request_body']),
           auth= AUTH
        )
               
              
        

print('\n')
print('Printing get_bios_policy')
print(get_bios_policy)
print('\n')
print('Printing response')
print(responseget)
print('\n')
print('******************')
print('\n')
print(responseget.text)
print("Type of response is:", type(responseget))
print("Type of response.text is:", type(responseget.text))
print('\n')
print('#################################')
print('\n')
print('Printing get_bios_policy')
print(post_bios_policy)
print('\n')
print('Printing response')
print(responsepost)
print('\n')
print('******************')
print('\n')
#print(responsepost.text)
print("Type of response is:", type(responsepost))
print("Type of response.text is:", type(responsepost.text))


#Here is where we start using the REST API response and turning into Excel file
new_response = responseget.json()["Results"]

print("After converting response to json is:", type(new_response))
print('\n')
print('******************')
print('\n')
print(new_response)
print('\n')

filename = 'bios_policies.csv'
data_file = open(filename, 'w') 
csv_writer = csv.writer(data_file) 
count = 0

for i in new_response:
    if count == 0:
        header = i.keys()
        csv_writer.writerow(header)
        count += 1

    csv_writer.writerow(i.values())

data_file.close()
print('File saved to:', filename)


