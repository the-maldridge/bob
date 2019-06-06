# Bob the Build Service

Bob is a small shell script which makes it easy to build and update a
repository of Go tools.  In theory the system can also build Rust
binaries, PAR archives, Phar archives, and other similar single
package result artifacts.

To use, create a configuration file called `conf` and put it in the
directory where you cloned this repository.  This will configure the
parameters needed to run the service.  For information on what you can
configure, consult the anotated `examples/conf`.  Next, add some
templates in a directory named `tmpl` next to the bob script.  See
`examples/template` get an idea of how a template is built.

Simply run bob and it will build any artifacts that are missing from
the repository.  You may wish to schedule bob on a cron job, or on a
push hook of your template repository.
