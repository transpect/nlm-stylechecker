<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
  xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:c="http://www.w3.org/ns/xproc-step" 
  xmlns:tr="http://transpect.io"
  version="1.0" 
  exclude-inline-prefixes="#all" 
  name="stylecheck"
  type="tr:nlm-stylechecker">

  <p:option name="debug" required="false" select="'no'"/>
  <p:option name="debug-dir-uri" select="'debug'"/>
  <p:option name="status-dir-uri" select="'status'"/>
  <p:option name="remove-srcpaths" required="false" select="'true'"/>

  <p:input port="source" primary="true" >
    <p:documentation>A JATS 1.0 or 1.1 document.</p:documentation>
  </p:input>
  <p:input port="checking-stylesheet" primary="false" sequence="true">
    <p:document href="../xsl/nlm-stylechecker.xsl"/>
  </p:input>
  <p:input port="parameters" kind="parameter" primary="true"/>

  <p:output port="report" primary="true" sequence="true">
    <p:documentation>SVRL report</p:documentation>
    <p:pipe step="errorPI2svrl" port="report"/>
  </p:output>
  
  <p:import href="http://transpect.io/xproc-util/store-debug/xpl/store-debug.xpl"/>
  <p:import href="http://transpect.io/htmlreports/xpl/errorPI2svrl.xpl"/>

  <p:xslt name="nlm-stylecheck">
    <p:input port="stylesheet">
      <p:pipe port="checking-stylesheet" step="stylecheck"/>
    </p:input>
    <p:input port="parameters">
      <p:pipe port="parameters" step="stylecheck"/>
    </p:input>
  </p:xslt>

  <tr:store-debug pipeline-step="nlm-stylechecker/pi">
    <p:with-option name="active" select="$debug"/>
    <p:with-option name="base-uri" select="$debug-dir-uri"/>
  </tr:store-debug>

  <tr:errorPI2svrl name="errorPI2svrl" severity="warning">
    <p:with-option name="group-by-srcpath" select="'no'"/>
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="status-dir-uri" select="$status-dir-uri"/>
  </tr:errorPI2svrl>

  <p:sink/>

  <tr:store-debug pipeline-step="nlm-stylechecker/svrl">
    <p:input port="source">
      <p:pipe port="report" step="errorPI2svrl"/>
    </p:input>
    <p:with-option name="active" select="$debug"/>
    <p:with-option name="base-uri" select="$debug-dir-uri"/>
  </tr:store-debug>
  
  <p:sink/>

</p:declare-step>
