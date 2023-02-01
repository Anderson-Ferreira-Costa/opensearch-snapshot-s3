import boto3
import requests
from requests_aws4auth import AWS4Auth
from datetime import date

host = 'https://vpc-meios-de-pagamentos-prd-smyl652kbppqus5htk4wknuvxm.ca-central-1.es.amazonaws.com/' # include https:// and trailing /
region = 'ca-central-1' # e.g. us-west-1
service = 'es'
credentials = boto3.Session().get_credentials()
date = date.today()

awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)

# Take snapshot

path = f'_snapshot/snapshot-s3/snapshot-{date}'
url = host + path

r = requests.put(url, auth=awsauth)

print(r.text)


# # Restore snapshot (one index)
#
# path = '_snapshot/snapshot-s3/snapshot-***/_restore'
# url = host + path
#
# payload = {"indices": "my-index"}
#
# headers = {"Content-Type": "application/json"}
#
# r = requests.post(url, auth=awsauth, json=payload, headers=headers)
#
# print(r.text)



# Register repository
#
#path = '_snapshot/snapshot-s3' # the OpenSearch API endpoint
#url = host + path
#
#payload = {
#  "type": "s3",
#  "settings": {
#    "bucket": "meios-de-pagamento-prd-opensearch-bkp",
#    "region": "ca-central-1",
#    "role_arn": "arn:aws:iam::399469105601:role/TheSnapshotRole"
#  }
#}
#
#headers = {"Content-Type": "application/json"}
#
#r = requests.put(url, auth=awsauth, json=payload, headers=headers)
#print(r.status_code)
#print(r.text)
#
# # Delete index
#
# path = 'my-index'
# url = host + path
#
# r = requests.delete(url, auth=awsauth)
#
# print(r.text)
#
# # Restore snapshot (all indexes except Dashboards and fine-grained access control)
#
# path = '_snapshot/my-snapshot-repo-name/my-snapshot/_restore'
# url = host + path
#
# payload = {
#   "indices": "-.kibana*,-.opendistro_security",
#   "include_global_state": False
# }
#
# headers = {"Content-Type": "application/json"}
#
# r = requests.post(url, auth=awsauth, json=payload, headers=headers)
#
# print(r.text)
# 
