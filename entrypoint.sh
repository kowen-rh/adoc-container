#!/bin/sh

# When run as the entrypoint, this script decides whether to generate HTML
# or PDF output through `asciidoctor` or `asciidoctor-pdf`, respectively.
# 
# An argument of `html` or `pdf` is required followed by the name of the
# AsciiDoc-formatted file used to render output. Any extra arguments given
# to this script will be passed directly to the respective command for each
# output format.

case $1 in
  html)
    # Given `html`, render using `asciidoctor`. Discard the initial `html`
    # argument with `shift`, then run `asciidoctor` with the remaining
    # arguments.
    echo 'generating html'
    shift
    asciidoctor "$@" ;;
  pdf)
    # Likewise, given `pdf`, render using `asciidoctor-pdf`.
    echo 'generating pdf'
    shift
    asciidoctor-pdf "$@" ;;
  *)
    # For any other initial argument, print a usage message and exit with
    # an error status of 1.
    echo 'err: must provide one of: [html, pdf]'
    exit 1 ;;
esac
