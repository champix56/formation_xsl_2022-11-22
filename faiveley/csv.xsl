<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:cv="urn:formation:xml:cv" xmlns="urn:formation:xml:cv" xmlns:mesFunc="urn:orsys:functions" exclude-result-prefixes="xs cv">
	<xsl:output method="text"/>
	<xsl:include href="lib.xsl"/>
	<xsl:template match="/">idcv;nom;prenom;date naissance;age;langues;nb diplomes<xsl:apply-templates select="//cv:cv"/>
	</xsl:template>
	<xsl:template match="cv:datenaiss|cv:nom|cv:pnom|cv:cv/@id">
		<xsl:value-of select="."/>;</xsl:template>
	<xsl:template match="cv:cv">
		<xsl:text>
</xsl:text>
		<xsl:apply-templates select="@id|cv:ident/cv:nom|cv:ident/cv:pnom[1]|cv:ident/cv:datenaiss"/>
		<xsl:value-of select="mesFunc:calcul-age(cv:ident)"/>
		<!--<xsl:call-template name="calcul-age">
			<xsl:with-param name="baseNodeDate" select="cv:ident"/>
		</xsl:call-template>-->
	</xsl:template>
	<!--


-->
	</xsl:stylesheet>
