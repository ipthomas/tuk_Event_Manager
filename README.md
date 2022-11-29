# tuk_Event_Manager

Deployment has only been testing on a MacOS intel platform

To Deploy:

The simplest way to install is to to git clone github.com/ipthomas/Tuk_Event_Manager_Install and run the install.sh script

To install manually:
    
    1) Create a sub folder /certs in the /config folder and save your server cert and server key files in the /certs folder
    
    2) Edit the ./config/envvars.json file. Enter the values for your deployment
        i.e "dbuser": "" -> "dbuser": "root"
        'dbxxxx' are your Database credentials
        'broker' is the WSE url of your dsub broker
        'consumer' is the WSE url of the Event Manager DSUB Consumer.
        'regoid' is your assigned regional OID for your HIE

    3) Initilalise the Database and tables
        Edit each of the ./config/services/{{service_name}}srvc.json files with the values for your deployment
        
    4)  From the /main folder... run './tuk init db'
            This will create
                A database with the name specified in the envvars.json file param "dbname"
                The Event Manager tables (events,subscriptions,templates,servicestates,idmaps,xdws and workflows)

    5)  Create folder .config/xdwconfig and save your Workflow Definitions for each Workflow to be supported in .config/xdwconfig/
        Each workflow definition requires a corresponding meta data file for use when publishing the workflow.
        Each Workflow definition filename format must be {{workflow}}_def.json
        Each Workflow meta data filename format must be {{orkflow}}_meta.json

        There are Example workflow definitions and corresponding meta data files in .config/xdwconfig_examples/. Included for initial deployment testing / illustration Only.

    6)  Start Event Manager
            From the folder you installed the package into... run './main'

