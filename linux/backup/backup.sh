profile=$(dirname $0)
TIME=`date +'%Y%m%dT%H%M%S'`
BAK="backup-${TIME}.tar.gz"
tar -zcf $BAK $(cat $profile/files)