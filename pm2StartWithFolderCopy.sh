#!/usr/bin/env bash
# az webapp deployを利用したデプロイでは、zipファイル化されたパッケージ内にあるフォルダが、
# /home/site/wwwrootに配備されないという事象が発生する。
# 回避策として、azure app serviceのbuild実行後に、/tmp/zipdeploy/extractedから
# フォルダをコピーして、/home/site/wwwrootに配備する。 

ENV=$1
WWWROOT=/home/site/wwwroot

targetDirs=("config" "dist" "prisma" "public")

echo "`date "+%Y-%m-%d %H:%M:%S"` pm2StartWithFolderCopy start."
for dir in "${targetDirs[@]}"
do
  if [ -f "${WWWROOT}/${dir}.tar.gz" ]; then
    if [ -d "${WWWROOT}/${dir}" ]; then
      echo "rm -rf ${WWWROOT}/${dir}"
      rm -rf ${WWWROOT}/${dir}
    fi
    mkdir ${dir}
    echo "tar -xzf ${WWWROOT}/${dir}.tar.gz -C ${dir}"
    tar -xzf ${WWWROOT}/${dir}.tar.gz -C ${dir}
    echo "rm ${WWWROOT}/${dir}.tar.gz"
    rm ${WWWROOT}/${dir}.tar.gz
  fi
done
echo "`date "+%Y-%m-%d %H:%M:%S"` pm2StartWithFolderCopy pm2 start."
pm2 start ./ecosystem.config.cjs --no-daemon --env ${ENV}
