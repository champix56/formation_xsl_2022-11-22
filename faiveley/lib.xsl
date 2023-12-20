<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:cv="urn:formation:xml:cv" xmlns="urn:formation:xml:cv" xmlns:mesFunc="urn:orsys:functions">
	<xsl:function name="mesFunc:calcul-age" as="xs:integer">
		<xsl:param name="baseNodeDate" as="node()"/>
		<xsl:variable name="age_tmp" select="year-from-date(current-date()) - year-from-date($baseNodeDate/cv:datenaiss)"/>
		<xsl:variable name="datenaiss_mmdd" select="fn:replace(fn:substring(xs:string($baseNodeDate/cv:datenaiss),6),'-','')"/>
		<xsl:variable name="current_mmdd" select="fn:replace(fn:substring(xs:string(current-date()),6),'-','')"/>
		<xsl:choose>
			<xsl:when test="month-from-date(current-date())> month-from-date($baseNodeDate/cv:datenaiss) or (month-from-date(current-date()) = month-from-date($baseNodeDate/cv:datenaiss) and day-from-date(current-date())>=day-from-date($baseNodeDate/cv:datenaiss))">
				<!--		<xsl:when test="number($datenaiss_mmdd) &lt; number($current_mmdd)">-->
				<xsl:value-of select="$age_tmp+1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$age_tmp"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

</xsl:stylesheet>
