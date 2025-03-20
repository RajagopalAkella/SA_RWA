About "Super Agent with word auditing package":
Agentforce Agents are being part of our daily work, interacting with them to reduce the effort and at the same time to automate generic work and making our life easy. These agents are best workers when we give the clear instructions and give them defined and specific work to handle. The security aspect is pretty well handled at the Salesforce integration level with these LLMs (Large Language Models). However, there are some scenarios where we would want to track / audit specifically some restricted words as per the specific company or organizational policies. When we develop an agent, we are giving a way to the user and the Agent a window to communicate through the keyboard and they can type anything in it, and based on the input, the agents may also respond repeating those specific keywords which are given to it.
Now, the intention is to make it clear on following the policies and procedures to the employees or users, there is still a possibility of typos that would make these words / personally identifiable information (PII) or confidential information to be entered to the chat / as an input to the agents. 
This solution is going to address the needs of the customers in this case, by constantly monitoring the words among the provided list of words and capture the instances where these are entered, and it will be masked before giving the response from agent to the user. Simultaneously, these will be entered into the audit, capturing who entered and what was entered, and when was entered, giving a clear report and provision to create dashboards. 

Since these words are entered in a custom object, it can be made as custom list specific to the organization.
Also, the custom model can be configurable by entering it in the Custom Lable which comes as part of the package.

Steps to ensure before installing this package:
1. Setup > Einstein Setup > Turn on Einstein
2. Setup > Agents > Enable Agentforce
3. Setup > Einstein for Sales > Turn on Sales Emails
4. Load the VulnerableWordsData.csv available in \data folder by going to Setup > Data Import Wizard (ignore first two columns while mapping "ID, SA Restricted Word Name")
Note: Above 4th point is specific to the requirement. If you don't need this data, and have your specific data, you can ignore this load, and enter your load in SA_Restricted_Word__c object.

Checking the working of component post installation of package:
1. Assign this permission set to user / profile: SA_RWA_Permission
2. Modify Custom Label "SA_CustomAgentModel" Value to any of the supported models listed below (deployed with value "sfdc_ai__DefaultOpenAIGPT4OmniMini"):
https://developer.salesforce.com/docs/einstein/genai/guide/supported-models.html
3. Click on all apps, and find "Super Agent With Word Auditing"
4. On the Home tab, the agent and Audits object are placed to see the working and the output records.

When you want to Uninstall:
1. Remove / delete the assigned permission set "SA_RWA_Permission" to any user.
2. Go to Installed Packages and click on Uninstall.