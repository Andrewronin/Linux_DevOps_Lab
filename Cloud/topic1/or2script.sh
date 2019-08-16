# run VM

or2run -p personal -r EPAM-BY2 -i image -s shape

or2report -p personal -t quota -m 12 -y 2017

# Checkpoint

or2ccp -p project -r region -i instance_id -d checkpoint_description

or2dcp -p project -r region -i instance_id

or2gcp -p project -r region -i instance_id -c checkpoint_id

or2rcp -p project -r region -i instance_id

or2delcp -p project -r region -i instance_id -c checkpoint_id

# Images

or2cim -p project -r region -i instance_id -n image_name -d image_description

or2dim -p project -r region

or2run -p project -r region -s shape -i image_id

or2delim -p project -r region -i image_id

# Scedule

or2addsch -p project -r region -a action -c cronExpression -n schedule_name -i instance_id 

or2schaddi -p project -r region -i instance_id -n schedule_name

or2schremi -p project -r region -n schedule_name -i instance_id

or2dsch -p project -r region

or2delsch -p project -r region -n schedule_name

# Audit

or2audit -p project -r region

or2audit -p project -r region -i instance_id -d 30

or2audit -p project -r region --from yyyy-MM-dd --to yyyy-MM-dd

or2din -p project -r region --audit

# Stack

or2uf -p project -f file_path --type eo-template -d template_description

or2rmstack -p project -r region -s “stack_name” -m abcolute_path_to_template_file

or2rmstack -p project -r region -s stack_name -t template_name

or2dmstack -p project -r region 

or2dmsr -p project -r region -s stack-id

or2delmstack -p project -r region -s stack-id

# Chef

or2setp -i instance_id -r region -h role1 -h role2 -c value1 -c "recipename1.attribute1=value2" -p project

or2setp -i instance_id -p project -r region -h tomcat7 -h lamp  -c "tomcat.port=8080" -c "tomcat.ajp_port=8009" -c "apache.default_site_enabled=true"

or2getp -p project -r region -i instance_id

or2delp -p project -r region -i instance_id -n property_name1 -n property_name2...


# Zabbix

or2ms -p project -r region -s monitoring --activate

or2mon -p project -r region -i instance_id

or2dmon -p project -r region 

or2stopmon -p project -r region -i instance_id

or2ms -p project -r region -s monitoring --deactivate 


