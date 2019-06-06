#!/bin/sh

# The filesystem driver is the most basic repository manager.  It
# writes files to a single directory somewhere on the disk, and then
# checks that location for files to see if artifacts are built.  The
# location can be configured with the variable BOB_FS_BASE.  To use
# the filesystem repo, set BOB_REPO_MODE to FS.

# On load we need to make sure that the repository has been set.  If
# the token isn't set, then set it to be $BOB_BASEDIR/artifacts/.

if [ -z "$BOB_FS_BASE" ] ; then
    BOB_FS_BASE="$BOB_BASEDIR/artifacts"
fi

# This function just checks if the artifact exists which is easy on
# the filesystem.  This also depends on the repository structure,
# which is $base/$name/$version/$name.
artifact_exists() {
    if [ -f "$BOB_FS_BASE/$1/$2/$1" ] ; then
        return 0
    else
        return 1
    fi
}

# This function writes an artifact from the stage directory with the
# format $name-$version to the artifact repository.  It will check if
# the file is missing, but the logs should still be reviewed when
# practical.
write_artifact() {
    if [ ! -f "$BOB_BASEDIR/stage/$1-$2" ] ; then
        echo "File $BOB_BASEDIR/stage/$1-$2 is missing!  Was the build successfull?"
        return
    fi

    mkdir -p "$BOB_FS_BASE/$1/$2"
    cp -v "$BOB_BASEDIR/stage/$1-$2" "$BOB_FS_BASE/$1/$2/$1"

    # Clean up the staged file
    rm -f "$BOB_BASEDIR/stage/$1-$2"
}
