<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
	<xsl:template match="/">
		<html>
			<head>
				<title/>
				<style type="text/css">
						.class_facture{
						/*contenu css de la class facture*/
						
						/*saut de page "avant la balise" lors de l'impression uniquement*/
							page-break-before:always;
							height:287mm;
							border-bottom:1px solid grey;
						}
						.class_numfacture{
							text-align:center;
							padding:5mm 10mm;
							margin-bottom:1cm;
							margin-top:4cm;
							width:60%;
							margin-left:20%;
							margin-right:20%;
							border:1px solid black;
						}
				</style>
			</head>
			<body>
				<h1>Liste des factures</h1>
				<ul>
					<xsl:apply-templates select="//facture"/>
				</ul>
				<hr/>
				<xsl:apply-templates select="//facture" mode="facture-body"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="facture">
		<li>
			<a href="#F-{@numfacture}">
				<xsl:apply-templates select="@numfacture"/>
			</a>
		</li>
	</xsl:template>
	<xsl:template match="facture" mode="facture-body">
		<div class="class_facture" id="F-{@numfacture}">
			<div class="class_numfacture">
				<xsl:apply-templates select="@numfacture"/>
			</div>
			<xsl:apply-templates select="lignes"/>
		</div>
	</xsl:template>
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
	<!--niveau de priority implicite(emit par la complexité du match) equivalant donc attrib priority pour elever la priorité face a ligne/*-->
	<xsl:template match="ligne/phtByUnit | ligne/stotligne" priority="2">
		<td>une cell specifique</td>
	</xsl:template>
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
		</table>
	</xsl:template>
	<xsl:template match="@numfacture">
		<xsl:choose>
			<xsl:when test="contains(../@type,'evis')">Devis</xsl:when>
			<xsl:otherwise>Facture</xsl:otherwise>
		</xsl:choose> N° <xsl:value-of select="."/>
	</xsl:template>
</xsl:stylesheet>
