#!/bin/bash

while getopts ":Mmp" Option
do
  case $Option in
    M ) major=true;;
    m ) minor=true;;
    p ) patch=true;;
  esac
done

shift $(($OPTIND - 1))

VERSION=`cat version`

a=( ${VERSION//./ } )

if [ ${#a[@]} -ne 2 ]
then
  echo "usage: $(basename $0) [-Mmp]"
  exit 1
fi

# Increment version numbers as requested.

if [ ! -z $major ]
then
  ((a[0]++))
  a[1]=0
  a[2]=0
fi

if [ ! -z $minor ]
then
  ((a[1]++))
  a[2]=0
fi

echo "${a[0]}.${a[1]}"

VERSION="${a[0]}.${a[1]}"

SERVER_USERNAME="user1"
SERVER_ARRD="10.0.7.2"
SERVER_PORT="22"
DOMAIN="web-app.touchin.ru"

if [[ $NODE_ENV ]]; then
	SERVER_USERNAME="touchin"
	SERVER_ARRD="server1.production.ru"
	SERVER_PORT="22"
	DOMAIN="web-app.production.ru"
fi

DEPLOY_PATH="/srv/$DOMAIN/static_builds"
STATIC_PATH="/srv/$DOMAIN/static"
APP_NAME="dominosadmin_v$VERSION"
APP_PATH="$DEPLOY_PATH/$APP_NAME"

echo "upload $APP_NAME to $SERVER_ARRD"

npm run prod

cd dist && tar zcfv "$APP_NAME.tgz" *

scp -P $SERVER_PORT "$APP_NAME.tgz" "$SERVER_USERNAME@$SERVER_ARRD:$DEPLOY_PATH/"

ssh -p $SERVER_PORT "$SERVER_USERNAME@$SERVER_ARRD" \
	"mkdir $APP_PATH && tar xfzv $APP_PATH.tgz --directory $APP_PATH && ln -sfT $APP_PATH $STATIC_PATH"

cd ..

echo "$VERSION" > ./version
