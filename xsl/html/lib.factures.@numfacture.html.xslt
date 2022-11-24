<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="@numfacture">
		<xsl:choose>
			<xsl:when test="contains(../@type,'evis')">Devis</xsl:when>
			<xsl:otherwise>Facture</xsl:otherwise>
		</xsl:choose> N° <xsl:value-of select="."/>
	</xsl:template>
	
</xsl:stylesheet>
