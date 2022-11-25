<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:doc="http://docbook.org/ns/docbook" xmlns="http://docbook.org/ns/docbook">
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4">
					<fo:region-body margin-top="2cm"/>
					<fo:region-before extent="2cm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="A4">
				<fo:static-content flow-name="xsl-region-before">
					<fo:block>
						<!--remplissage conditionnel d'une variable-->
						<xsl:variable name="conditionnalImagePath">
							<xsl:choose>
										<xsl:when test="/*/@xml:lang='en' ">english.jpg</xsl:when>
										<xsl:otherwise>french.jpg</xsl:otherwise>
									</xsl:choose>
						</xsl:variable>
					<fo:external-graphic src="{$conditionnalImagePath}" content-height="2cm" content-width="2cm" scaling="uniform"/>
					
						
						<fo:instream-foreign-object content-height="2cm" scaling="uniform">
							<svg xmlns="http://www.w3.org/2000/svg">
								<text x="0" y="20" font-size="30">
									<xsl:choose>
										<xsl:when test="/*/@xml:lang='en' ">En anglais</xsl:when>
										<xsl:otherwise>titre en fr</xsl:otherwise>
									</xsl:choose>
								</text>
							</svg>
						</fo:instream-foreign-object>
					</fo:block>
				</fo:static-content>
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<xsl:apply-templates select="/doc:article"/>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template match="doc:article">
		<xsl:apply-templates select="doc:section"/>
	</xsl:template>
	<xsl:template match="doc:section">
		<xsl:apply-templates select="doc:table"/>
	</xsl:template>
	<xsl:template match="doc:table">
		<xsl:param name="border" select="'0.3mm solid black'"/>
		<fo:block>
			<fo:table>
				<xsl:apply-templates select="./doc:tgroup/doc:thead|./doc:tgroup/doc:tbody">
					<xsl:with-param name="border" select="$border"/>
				</xsl:apply-templates>
			</fo:table>
			<xsl:apply-templates select="doc:title"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="doc:thead">
		<xsl:param name="border"/>
		<fo:table-header>
			<xsl:apply-templates select="./*">
				<xsl:with-param name="border" select="$border"/>
			</xsl:apply-templates>
		</fo:table-header>
	</xsl:template>
	<xsl:template match="doc:tbody">
		<xsl:param name="border"/>
		<fo:table-body>
			<xsl:apply-templates select="./*">
				<xsl:with-param name="border" select="$border"/>
			</xsl:apply-templates>
		</fo:table-body>
	</xsl:template>
	<xsl:template match="doc:row">
		<xsl:param name="border"/>
		<fo:table-row>
			<xsl:apply-templates select="./*">
				<xsl:with-param name="border" select="$border"/>
			</xsl:apply-templates>
		</fo:table-row>
	</xsl:template>
	<xsl:template match="doc:row/doc:entry">
		<xsl:param name="border"/>
		<fo:table-cell xsl:use-attribute-sets="color_and_center">
			<xsl:attribute name="border"><xsl:choose><xsl:when test="string-length($border)>0"><xsl:value-of select="$border"/></xsl:when><xsl:otherwise>none</xsl:otherwise></xsl:choose></xsl:attribute>
			<fo:block>
				<xsl:value-of select="."/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
	<xsl:template match="doc:table/doc:title">
		<fo:block text-align="right" font-style="italic" font-size="10pt">
			<xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	<!--liste d'attribut pour usage css class like  avec xsl:use-attribute-sets cf ligne 87-->
	<xsl:attribute-set name="color_and_center">
		<xsl:attribute name="color">blue</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>
