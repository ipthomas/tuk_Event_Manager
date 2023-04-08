/*
 * This file is subject to the terms and conditions defined in
 * file 'LICENSE', which is part of this source code package.
 */

package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/ipthomas/tukcnst"
	"github.com/ipthomas/tukdbint"
	"github.com/ipthomas/tukint"

	"github.com/aws/aws-lambda-go/lambda"
)

type EnvVars struct {
	DB_User           string `json:"dbuser"`
	DB_PWD            string `json:"dbpwd"`
	DB_NAME           string `json:"dbname"`
	DB_Host           string `json:"dbhost"`
	DB_Port           string `json:"dbport"`
	DSUB_Broker_URL   string `json:"broker"`
	DSUB_Consumer_URL string `json:"consumer"`
	Log_Enabled       string `json:"logenabled"`
	Reg_OID           string `json:"regoid"`
}

func main() {
	os.Setenv("Log_Enabled", "true")
	loadEnvVars(tukint.Basepath + "envvars.json")
	if len(os.Args) > 1 && os.Args[1] == "init" {
		dbconn := tukdbint.TukDBConnection{DBUser: os.Getenv(tukcnst.ENV_DB_USER), DBPassword: os.Getenv(tukcnst.ENV_DB_PASSWORD), DBHost: os.Getenv(tukcnst.ENV_DB_HOST), DBPort: os.Getenv(tukcnst.ENV_DB_PORT), DBName: os.Getenv(tukcnst.ENV_DB_NAME)}
		if err := tukdbint.NewDBEvent(&dbconn); err != nil {
			log.Println(err.Error())
			return
		}
		log.Printf("Input Param %s provided", os.Args[1])
		if askForConfirmation("Persist New TUK Event Manager Configuration?") {
			switch len(os.Args) {
			case 2:
				log.Println("Persisting TUK Event Manager Configuration files")
				tukint.PersistServiceConfigs()
				tukint.PersistTemplates()
				tukint.PersistXDWConfigs()
			case 3:
				log.Printf("Persisting TUK Event Manager %s Configuration files", os.Args[2])
				switch os.Args[2] {
				case "srvcs":
					tukint.PersistServiceConfigs()
				case "tmplts":
					tukint.PersistTemplates()
				case "xdws":
					tukint.PersistXDWConfigs()
				case "db":
					tukint.InitDatabase("tuk.sql")
				default:
					log.Printf("param 2 value %s is not valid. Valid options are db,srvcs, tmplts,xdws", os.Args[2])
				}
			}
		}
		tukdbint.DBConn.Close()
		tukint.LogFile.Close()
		log.Printf("Closed DB Connection\nCreated %s Database. TUK Event Manager should be good to 'go' run ./tuk' !", os.Getenv(tukcnst.ENV_DB_NAME))
	} else {
		initTukManager()
	}
}
func initTukManager() {
	tukint.InitTuki()
	if tukint.Services.EventService.Enabled {
		log.Println("TUK Event Server is Enabled. Initialising Local Web Server")
		tukint.TukEventServer()
	} else {
		log.Println("TUK Event Server is Disabled. Initialising AWS Lambda Function")
		lambda.Start(tukint.Handle_AWS_API_GW_Request)
	}
}
func askForConfirmation(s string) bool {
	reader := bufio.NewReader(os.Stdin)
	for {
		fmt.Printf("%s [y/n]: ", s)
		response, err := reader.ReadString('\n')
		if err != nil {
			log.Fatal(err)
		}
		response = strings.ToLower(strings.TrimSpace(response))
		if response == "y" || response == "yes" {
			return true
		} else {
			return false
		}
	}
}
func loadEnvVars(file string) {
	var fileBytes []byte
	var err error
	fileBytes, err = os.ReadFile(file)
	if err != nil {
		log.Println(err.Error())
	} else {
		log.Printf("Loaded Environment Vars File %s ", file)
	}
	envs := EnvVars{}
	json.Unmarshal(fileBytes, &envs)
	if os.Getenv("Log_Enabled") == "" {
		os.Setenv("Log_Enabled", envs.Log_Enabled)
	}
	if os.Getenv(tukcnst.ENV_DB_PASSWORD) == "" {
		os.Setenv(tukcnst.ENV_DB_PASSWORD, envs.DB_PWD)
	}
	if os.Getenv(tukcnst.ENV_DB_USER) == "" {
		os.Setenv(tukcnst.ENV_DB_USER, envs.DB_User)
	}
	if os.Getenv(tukcnst.ENV_DB_HOST) == "" {
		os.Setenv(tukcnst.ENV_DB_HOST, envs.DB_Host)
	}
	if os.Getenv(tukcnst.ENV_DB_PORT) == "" {
		os.Setenv(tukcnst.ENV_DB_PORT, envs.DB_Port)
	}
	if os.Getenv(tukcnst.ENV_DB_NAME) == "" {
		os.Setenv(tukcnst.ENV_DB_NAME, envs.DB_NAME)
	}
	if os.Getenv(tukcnst.ENV_DSUB_BROKER_URL) == "" {
		os.Setenv(tukcnst.ENV_DSUB_BROKER_URL, envs.DSUB_Broker_URL)
	}
	if os.Getenv(tukcnst.ENV_DSUB_CONSUMER_URL) == "" {
		os.Setenv(tukcnst.ENV_DSUB_CONSUMER_URL, envs.DSUB_Consumer_URL)
	}
	if os.Getenv(tukcnst.ENV_REG_OID) == "" {
		os.Setenv(tukcnst.ENV_REG_OID, envs.Reg_OID)
	}
}
