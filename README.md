# tuk_Event_Manager

To Deploy:
    
    1) Create and save the server cert and server key files in the cert folder if using https
    
    2) Edit the ./config/envvars.json file. Replace each paramater value{{... }}} with the values for your deployment
        i.e "dbuser": "{{database user}}" -> "dbuser": "root"

    3) Initilalise the Database and tables
        Edit each of the ./config/services/{{service_name}}srvc.json files with the values for your deployment
        
    4)  From the folder you installed the package into... run 'go main/main.go init db'
            This will create
                A database with the name specified in the envvars.json file param "dbnamer"
                The Event Manager tables (events,subscriptions,templates,servicestates,idmaps,xdws and workflows)
            and populate the tables with default / dummy data.

    5)  Create and save your Workflow Definitions for each Workflow to be supported in .config/xdwconfig/
        Each workflow definition requires a corresponding meta data file for use when publishing the workflow.
        Each Workflow definition filename format must be {{workflow}}_def.json
        Each Workflow meta data filename format must be {{orkflow}}_meta.json

        There are Example workflow definitions and corresponding meta data files in .config/xdwconfig_examples/

    6)  Start Event Manager
            From the folder you installed the package into... run 'go main/main.go'
