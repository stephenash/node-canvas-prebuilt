OS=$1;
CANVAS_PREBUILT_VERSION=$2;
CANVAS_VERSION_TO_BUILD=$3;
NODEJS_VERSIONS=$4

if [ "$CANVAS_VERSION_TO_BUILD" = "" ]; then
  echo "Can't do anything since you didn't specify which version we're building!";
  echo "Specify the environment variable in AppVeyor/Travis"
  echo "Make sure that building pushes is disabled, and that you are executing builds manually."
  exit 0;
fi;

rm -rf node-canvas
git clone --branch v$CANVAS_VERSION_TO_BUILD --depth 1 https://github.com/Automattic/node-canvas.git || {
  echo "could not find node-canvas version $CANVAS_VERSION_TO_BUILD in NPM";
  exit 1;
}

npm install --ignore-scripts || {
  echo "failed npm install";
  exit 1;
}

if [ "$CANVAS_PREBUILT_VERSION" = "" ]; then
  echo "You need to specify the prebuilt version, which might be different than the"
  echo "canvas version that is being built"
  exit 0;
fi;

source ci/$OS/preinstall.sh

cp ci/$OS/binding.gyp node-canvas/binding.gyp

for ver in $NODEJS_VERSIONS; do
  echo "------------ Building with node $ver ------------"

  source ci/$OS/node_version.sh $ver;

  cd node-canvas

  node-gyp rebuild || {
    echo "error building in nodejs version $ver"
    exit 1;
  }

  cd ..

  source ci/$OS/bundle.sh;

  node -e "require('./node-canvas')" || {
    echo "error loading binary";
    exit 1;
  }

  source ci/tarball.sh $CANVAS_PREBUILT_VERSION;
done;
