#!/bin/sh

artifact_exists() {
    if [ -f "$BOB_FS_BASE/$1/$2/$1" ] ; then
        return 0
    else
        return 1
    fi
}

write_artifact() {
    if [ ! -f "$BOB_BASEDIR/stage/$1-$2" ] ; then
        echo "File $BOB_BASEDIR/stage/$1-$2 is missing!  Was the build successfull?"
        return
    fi

    mkdir -p "$BOB_FS_BASE/$1/$2"
    cp -v "$BOB_BASEDIR/stage/$1-$2" "$BOB_FS_BASE/$1/$2/$1"

    # Clean up the staged file
    rm "$BOB_BASEDIR/stage/$1-$2"
}
