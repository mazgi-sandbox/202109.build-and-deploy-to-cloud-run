# An Example

## How to run

Create .env file like below.

```
rm -f .env
test $(uname -s) = 'Linux' && echo -e "UID=$(id -u)\nGID=$(id -g)" >> .env
cat<<EOE >> .env
BIND_IP_ADDR=192.168.0.1
CLOUDSDK_CORE_PROJECT=YOUR_GCP_PROJECT_ID
CURRENT_ENV_NAME=production
PROJECT_UNIQUE_ID=YOUR_PROJECT_UNIZUE_ID
PUBLIC_IP_ADDR_OR_FQDN=203.0.113.1
EOE
```

Start Docker containers.

```shellsession
docker-compose up
```
