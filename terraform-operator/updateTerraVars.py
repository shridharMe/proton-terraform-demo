import json
import os
a_file = open("proton.auto.tfvars.json", "r")
json_object = json.load(a_file)
a_file.close()
json_object["environment"]["inputs"]["terraform_cloud_api_token"]  = os.environ['TERRAFROM_CLOUD_API_TOKEN']
json_object["environment"]["inputs"]["aws_access_key_id"] = os.environ['AWS_ACCESS_KEY_ID']
json_object["environment"]["inputs"]["aws_secret_access_key"] = os.environ['AWS_SECRET_ACCESS_KEY']
json_object["environment"]["inputs"]["aws_session_token"] = os.environ['AWS_SESSION_TOKEN']
a_file = open("proton.auto.tfvars.json", "w")
json.dump(json_object, a_file)

a_file.close()
