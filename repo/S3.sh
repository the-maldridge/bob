#!/bin/sh

# The S3 driver manages artifacts on an AWS S3.  It uses the AWS CLI
# and so is effectively non-portable to custom S3 implementations.

if [ -z "$BOB_S3_BASE" ] ; then
    BOB_S3_BASE="bob"
fi

# This function checks the remote bucket to determine if the object
# exists.  The path is $BOB_S3_BASE/$name/$version/$name.
artifact_exists() {
    if ! aws s3api head-object --bucket "$BOB_S3_BUCKET" --key "$BOB_S3_BASE/$1/$2/$1" >/dev/null 2>&1 ; then
        return 1
    else
        return 0
    fi
}

# Write artifact will best-effort copy the artifact up to S3.
write_artifact() {
    if [ ! -f "$BOB_BASEDIR/stage/$1-$2" ] ; then
        echo "File $BOB_BASEDIR/stage/$1-$2 is missing!  Was the build successfull?"
        return
    fi

    aws s3 cp "$BOB_BASEDIR/stage/$1-$2" "s3://$BOB_S3_BUCKET/$BOB_S3_BASE/$1/$2/$1"
    rm -f "$BOB_BASEDIR/stage/$1-$2"
}
