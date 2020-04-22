OS=$1;
PREBUILD_VERSION=$2;

echo "------------ Releasing with release.js ------------"
source ci/$OS/node_version.sh 11
node ci/release.js $PREBUILD_VERSION || exit 1;
