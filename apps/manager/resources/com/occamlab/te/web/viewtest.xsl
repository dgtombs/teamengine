<?xml version="1.0" encoding="UTF-8"?>
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  The contents of this file are subject to the Mozilla Public License
  Version 1.1 (the "License"); you may not use this file except in
  compliance with the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/ 

  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
  the specific language governing rights and limitations under the License. 

  The Original Code is TEAM Engine.

  The Initial Developer of the Original Code is Northrop Grumman Corporation
  jointly with The National Technology Alliance.  Portions created by
  Northrop Grumman Corporation are Copyright (C) 2005-2006, Northrop
  Grumman Corporation. All Rights Reserved.

  Contributor(s): No additional contributors to date

 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<xsl:transform
 xmlns:te="java:com.occamlab.te.TECore"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ctl="http://www.occamlab.com/ctl"
 xmlns:saxon="http://saxon.sf.net/"
 exclude-result-prefixes="saxon"
 version="2.0">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	<xsl:output name="xml" omit-xml-declaration="yes" cdata-section-elements="ctl:comment ctl:body" indent="yes"/>

	<xsl:param name="namespace-uri"/>
	<xsl:param name="local-name"/>

	<xsl:template name="viewtest">
		<h2>Test <xsl:value-of select="@name"/></h2>
		<h3>Assertion:</h3>
		<xsl:value-of select="./ctl:assertion"/><br/>
		<h3>Links:</h3>
		<xsl:if test="count(./ctl:link) gt 0">
			<ul>
			<xsl:for-each select="./ctl:link">
				<xsl:variable name="title" select="./@title"/>
				<xsl:variable name="content" select="."/>
				<xsl:choose>
					<xsl:when test="not($title = '')">
						<li><a href="{$content}"><xsl:value-of select="$title"/></a></li>
					</xsl:when>
					<xsl:otherwise>
						<li><a href="{$content}"><xsl:value-of select="$content"/></a></li>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			</ul>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="/">
		<xsl:for-each select="//ctl:package/ctl:test[substring-after(@name, ':') = $local-name]">
			<xsl:variable name="prefix" select="substring-before(@name, ':')"/>
			<xsl:if test="namespace::*[name()=$prefix] = $namespace-uri">
				<xsl:call-template name="viewtest"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="/ctl:test">
			<xsl:call-template name="viewtest"/>
		</xsl:for-each>
	</xsl:template>
</xsl:transform>