#!groovy
import groovy.json.JsonSlurperClassic
node {

    //def BUILD_NUMBER=env.BUILD_NUMBER
    //def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    //def SFDC_USERNAME

    println 'SYSTEM VARIABLES:' 
    def HUB_ORG = env.HUB_ORG_DH
    println HUB_ORG
    def SFDC_HOST = env.SFDC_HOST_DH
    println SFDC_HOST
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    println JWT_KEY_CRED_ID
    def CONNECTED_APP_CONSUMER_KEY = env.CONNECTED_APP_CONSUMER_KEY_DH
    println CONNECTED_APP_CONSUMER_KEY
    def toolbelt = tool 'toolbelt'
    println toolbelt

    stage('checkout source') {
	    // when running in multi-branch job, one must issue this command
	    checkout scm
    }

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
	    stage('Deploye Code') {
		    if (isUnix()) {
			    rc = sh returnStatus: true, script: "${toolbelt} sf org login jwt --client-id ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwt-key-file ${jwt_key_file} --set-default-dev-hub --instance-url ${SFDC_HOST}"
		    }else{
			    //bat "${toolbelt} plugins:install salesforcedx@49.5.0"
			    bat "${toolbelt} update"
			    //bat "${toolbelt} auth:logout -u ${HUB_ORG} -p" 
			    rc = bat returnStatus: true, script: "${toolbelt} sf org login jwt --client-id ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwt-key-file ${jwt_key_file} --set-default-dev-hub --instance-url ${SFDC_HOST}"
		    }
		    if (rc != 0) { 
			    println 'inside rc not 0'
			    error 'hub org authorization failed' 
		    }
		    println rc
		    // deploy 
		    if (isUnix()) {
			    //rmsg = sh returnStdout: true, script: "${toolbelt} force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
			    rmsg = sh returnStdout: true, script: "${toolbelt} sf project deploy start --manifest manifest/package.xml --target-org ${HUB_ORG}"
		    }else{
			    rmsg = bat returnStdout: true, script: "${toolbelt} sf project deploy start --manifest manifest/package.xml --target-org ${HUB_ORG}"
			    //rmsg = bat returnStdout: true, script: "${toolbelt} force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
		    }
		    printf rmsg
		    println('Hello from a Job DSL script!')
		    println(rmsg)
	    }
    }
}
