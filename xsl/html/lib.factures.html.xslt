<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="ligne">
		<tr>
			<xsl:apply-templates select="*[not(name()='surface')]"/>
			<!--td><xsl:value-of select="ref"/></td>
			<td><xsl:value-of select="designation"/></td>
			<td><xsl:value-of select="nbUnit"/></td>
			<td><xsl:value-of select="phtByUnit"/></td>
			<td><xsl:value-of select="stotligne"/></td-->
		</tr>
	</xsl:template>
	<!--niveau de priority implicite equivalant(emit par la complexité du match ici similaire a ligne/*)  donc attrib priority pour elever la priorité-->
	<xsl:template match="ligne/phtByUnit | ligne/stotligne" priority="2">
		<!--usage avec decimal format. utilisation possible sans decimal format si le pattern respect le standar (. pour le decimal par exemple)-->
		<td>
			<xsl:value-of select="format-number(.,'# ##0,00€','euro-format')"/>
		</td>
	</xsl:template>
	<xsl:template match="ligne/nbUnit" priority="2">
		<!--usage avec decimal format. utilisation possible sans decimal format si le pattern respect le standar (. pour le decimal par exemple)-->
		<td>
			<xsl:value-of select="format-number(.,'# ##0,00','euro-format')"/>
		</td>
	</xsl:template>
	<!--template pour un enfnt de ligne sans specification particuliere-->
	<xsl:template match="ligne/*">
		<td>
			<xsl:value-of select="."/>
		</td>
	</xsl:template>
	<xsl:template match="lignes">
		<table>
			<tr>
				<th>ref</th>
				<th>designation</th>
				<th>€/Unit</th>
				<th>quant.</th>
				<th>s-total</th>
			</tr>
			<xsl:apply-templates select=".//ligne"/>
			<xsl:call-template name="total-facture"/>
		</table>
	</xsl:template>
	<xsl:template match="@numfacture">
		<xsl:choose>
			<xsl:when test="contains(../@type,'evis')">Devis</xsl:when>
			<xsl:otherwise>Facture</xsl:otherwise>
		</xsl:choose> N° <xsl:value-of select="."/>
	</xsl:template>
	<xsl:template name="total-facture">
		<xsl:param name="nodesetFacture" select="."/>
		<tr>
			<th colspan="3" style="boder:none"/>
			<th>Total :</th>
			<th style="border:1px solid black">
				<xsl:value-of select="format-number(sum($nodesetFacture//stotligne),'# ##0,00€','euro-format')"/>
			</th>
		</tr>
	</xsl:template>
</xsl:stylesheet>
