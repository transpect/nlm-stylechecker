# nlm-stylechecker
XProcified + SVRLified version of the NLM StyleChecker

This is based on [software released by NCBI](http://www.ncbi.nlm.nih.gov/pmc/pub/stylechecker-info/).

It wraps the style checker in an XProc step and creates SVRL output.

It depends on other transpect modules. It is therefore not self-contained and needs to run in a project that also uses the libraries [htmlreports](https://github.com/transpect/htmlreports) and [xproc-util](https://github.com/transpect/xproc-util).

Please see the public domain notice in xsl/nlm-stylechecker.xsl
