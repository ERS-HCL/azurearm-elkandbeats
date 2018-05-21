# elk and beats in Azure VM
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FERS-HCL%2Fazurearm-elkandbeats%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FERS-HCL%2Fazurearm-elkandbeats%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>
This template allows you to deploy an instance of ELK and elk beats on a Linux Ubuntu 14.04 LTS VM. This will deploy a VM in the resource group location and return the FQDN of the VM and installs the components of elasticsearch, kibana, logstash, filebeat, metricbeat, packetbeat. The template provides configuration for elastic beats enabled for nginx, mysql, apache."

## A. Deploy elk docker VM
1. Click the "Deploy to Azure" button. If you don't have an Azure subscription, you can follow instructions to signup for a free trial.
2. Enter a valid name for the VM, as well as a user name and [ssh public key](https://docs.microsoft.com/azure/virtual-machines/virtual-machines-linux-mac-create-ssh-keys) that you will use to login remotely to the VM via SSH.
3. ELk Setup options 
This template can deploy ELK, Beats and sample services(nginx,apache,mysql). If you want to deploy only ELK, then in azuredeploy.json , you can change the parameter of elkserver = present and change the beat related and service related status = absent. 
To deploy only elkbeats, set parameters in azuredeploy.json [elkserver_status=absent, nginx_status=absent, apache_status=absent, mysql_status=absent].    

## B. Login remotely to the VM via SSH
Once the VM has been deployed, note down the DNS Name generated in the Azure portal for the VM. To login:
- If you are using Windows, use Putty or any bash shell on Windows to login to the VM with the username and password you supplied.
- If you are using Linux or Mac, use Terminal to login to the VM with the username and password you supplied.

## C. Setup SSH port forwarding
Once you have deployed the elk docker ARM template, you need to setup port forwarding to view the kibana UI on your local machine. If you do not know the full DNS name of your instance, go to the Portal and find it in the deployment outputs here: `Resource Groups > {Resource Group Name} > Deployments > {Deployment Name, usually 'Microsoft.Template'} > Outputs`

### If you are using Windows:
Install Putty or use any bash shell for Windows (if using a bash shell, follow the instructions for Linux or Mac).

Run this command:
```
putty.exe -ssh -i <path to private key file> -L 5601:localhost:5601 <User name>@<Public DNS name of instance you just created>
```

Or follow these manual steps:
1. Launch Putty and navigate to Change Settings > SSH > Tunnels
1. In the Options controlling SSH port forwarding window, enter 5601 for Source port. Then enter 127.0.0.1:5601 for the Destination. Click Add.
1. Navigate to 'Connection > SSH > Auth' and enter your private key file for authentication. For more information on using ssh keys with Putty, see [here](https://docs.microsoft.com/azure/virtual-machines/virtual-machines-linux-ssh-from-windows#create-a-private-key-for-putty).
1. Click Open to establish the connection.

### If you are using Linux or Mac:
Run this command:
```bash
ssh -i <path to private key file> -L 5601:localhost:5601 <User name>@<Public DNS name of instance you just created>
```
> NOTE: Port 5601 correspond to Kibana UI interface.

## E. Connect to Kibana

1. After you have started your tunnel, navigate to http://localhost:5601/ on your local machine, to view Kibana UI. Default Username: elastic, Password: changeme

