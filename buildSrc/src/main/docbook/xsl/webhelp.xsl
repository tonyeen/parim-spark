<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version='1.0'>
		<xsl:import href="docbook-xsl-ns-1.79.1/webhelp/xsl/webhelp.xsl"/>
	<xsl:import href="html.xsl"/>

    <xsl:param name="chunk.section.depth" select="1"/>
    <xsl:param name="use.id.as.filename" select="1"/>

    <xsl:param name="section.autolabel" select="1"/>
    <xsl:param name="chapter.autolabel" select="1"/>

    <xsl:param name="generate.section.toc.level" select="1"/>
</xsl:stylesheet>
