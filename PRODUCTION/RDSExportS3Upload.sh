#!/bin/bash

RDSEndpoint="chrome-prod.cgog2o5onsgb.us-west-2.rds.amazonaws.com"
RDSUsername="chrome" ;
RRDSPassword="PBdb2017!";
RDSDabaseName="chrome_staging"
AutomationDir="/home/ec2-user/automation"
AWSS3BucketPath="s3://mysqltoredshiftmigration20.03/new"

for TableName in $(cat $AutomationDir/tables/MysqlTableList.txt);
do
    echo "!!!!!!!!!!!!!!!!!!!! ${TableName} started the Export!!!!!!!!!!!!!" >>  $AutomationDir/Automation.log

    MysqlCMD=`mysql -h $RDSEndpoint -u $RDSUsername -p$RRDSPassword -e "select * FROM $TableName Limit 20000000" --database=$RDSDabaseName | sed -e 's/\t/,/g'| awk '{sub(/[^,]*/,"");sub(/,/,"")} 1' > $AutomationDir/csvfiles/$TableName.csv`
    #logs for RDS issuies
    echo $MysqlCMD >>  $AutomationDir/Automation.log

    echo "!!!!!!!!!!!!!!!!!!!! ${TableName} Export Completed !!!!!!!!!!!!!" >>  $AutomationDir/Automation.log
    #Upload Data to S3 Bucket
    AWSS3Copy=`aws s3 cp $AutomationDir/csvfiles/$TableName.csv $AWSS3BucketPath/$TableName.csv`
    #logs for AWS S3 Copy
    echo $AWSS3Copy >>  $AutomationDir/Automation.log
    echo "!!!!!!!!!!!!!!!!!!!! ${TableName} S3 Upload Completed !!!!!!!!!!!!!" >>  $AutomationDir/Automation.log
    #to delete the source file
    rm -rf $AutomationDir/csvfiles/$TableName.csv
     echo "!!!!!!!!!!!!!!!!!!!! ${TableName} deleted form source $AutomationDir/csvfiles/  Upload Completed !!!!!!!!!!!!!" >>  $AutomationDir/Automation.log
done
