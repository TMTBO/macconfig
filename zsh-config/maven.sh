# change maven version
function cmv() {

    mvn versions:set -DnewVersion=$1
    mvn -N versions:update-child-modules
}
