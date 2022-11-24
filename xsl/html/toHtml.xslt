<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
	<xsl:template match="/">
		<html>
			<head>
				<title></title>
				<style type="text/css">
						.class_facture{
						/*contenu css de la class facture*/
						
						/*saut de page "avant la balise" lors de l'impression uniquement*/
							page-break-before:always;
							height:287mm;
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
		<li><a href="#F-{@numfacture}">facture N°xx</a></li>
	</xsl:template>
	<xsl:template match="facture" mode="facture-body">
		<div class="class_facture" id="F-{@numfacture}">
			une facture
		</div>
	</xsl:template>
</xsl:stylesheet>
