# DevOps answers

## 1. Explain DB normalisation and why it's important, with an example

Database normalisation is a way to organise a DB into tables and columns, reducing redundancy and improving data integrity. It splits large tables into smaller, related ones, and ensures data dependencies are logical.

For example, I have a table with Customers and their Orders. Instead of storing the customer's full details repeatedly with each other, I'd create two tables:

- a Customer table, with columns for CustomerID, Name, Email
- an Orders table with a CustomerID, OrderID, and OrderDetails

The two tables are linked by the CustomerID

## 2. What is CICD and what are its prod and cons? What are the differences between CI and CD?

Continuous Integration and Continuous Deployment. CI automates the integration of coded changes in a shared repo (eg on Github). CI is important because it allows devs to be sure that their changes follow a set of standards defined within the team and they don't contain commonly found bugs. CD automates the delivery of the code to staginh and then on to production environments.

CICD enables faster development cycles, early detection of bugs, and consistent deployments.

Initial setup can be complex, though, and needs buy-in from the whole team.

## 3. What is the differene between Layer 3 and Layer 7 on the OSI model?

The Open Systems Intercommunication (OSI) model is a conceptual model that represents how network communications work.

Layer 3 handles the transfer of data between networks. It addresses and receives IP packets from other networks, making routing decisions based on the destination address. IP is the most significant protocol at this layer.

Layer 7 manages the application layer, so user-facing services such as HTTP or SMTP. It's the layer that users interact with directly, and it's closest to the end user.

Layer 3 focuses on where the data is going, while Layer 7 focuses on what the data is and how it's used.

# 4. You are working in a team and two pepole are trying to change the same file. How would you resolve this?

- I would use git to check for merge conflicts
- I would merge changes or ask for code to be refactored to included both updates

# 5. You need to create 10 servers in AWS. Which tools could be used to make sure they are all identical?

I would use Infrastructure as Code tools, such as Terraform. I'd define the server resource in a file, which I'd the use to create the identical servers.

# 6. What are some important security principles to follow as a devops engineer, and when building cloud services? What to they stop?

- POLP, principle of least privilege. This means giving users only the access they need, thus preventing over-permissioned accounts
- Patching. Regularly updating dependencies, which prevents exploits of known vulnerabilities. This can be automated in a git-based platform, such as Gitlab/Github
- Audit logs. Having visibility to access and changes in an environment, detecting unauthorised activity
- Observability, or monitoring applications and services, making them more reliable, resilient and available
- IAM management. Using strong identity controls to make sure only those authorised are accessing the network
- Immutable infrastructure. Deploying new infrastructure instead of modifying existing resources, thus ensuring consistency and security baselines. Using IaaC to create resources
- Secure secret management. Storing sensitive data in secure systems, such as AWS Secrets Manager, thus preventing leaking credentials in code