<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="lib.factures.html.xslt"/>
	<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
	<!--
		def. des particularité linguistiques d'un format de nombre a appliqué dans un format-number(node,'picture', 'euro-format')
		!!!non obligatoire en cas d'usage sur les standards numeriques americains (sparateur decimal / group, ...)
	-->
	<xsl:decimal-format name="euro-format" decimal-separator="," grouping-separator=" "/>
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
						table{
							width:80%;
							margin-left:10%;
							margin-right:10%;
							border-spacing:0;
						}
						td{
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
</xsl:stylesheet>
