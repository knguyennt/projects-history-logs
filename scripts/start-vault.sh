#!/bin/bash
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "❌ .env file not found!"
  exit 1
fi


docker run -p $PORT:$PORT --cap-add=IPC_LOCK -d --name $CONTAINER_NAME -e "VAULT_DEV_ROOT_TOKEN_ID=$VAULT_TOKEN" -e "VAULT_DEV_LISTEN_ADDRESS=$HOST:$PORT" $IMAGE_NAME
ngrok http --url=${NGROK_HOST} ${PORT}