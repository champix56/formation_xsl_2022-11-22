<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<factures>
			<xsl:apply-templates select="//facture"/>
		</factures>
	</xsl:template>
	<xsl:template match="facture">
		<facture>une facture</facture>
	</xsl:template>
	<xsl:template match="facture[contains(@type,'evis')]">
		<devis>une facture</devis>
	</xsl:template>
</xsl:stylesheet>
