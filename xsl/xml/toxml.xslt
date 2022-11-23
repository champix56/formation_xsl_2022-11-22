<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<factures>
			<xsl:apply-templates select="//facture"/>
		</factures>
	</xsl:template>
	<xsl:template match="facture">
		<!--xpath dans des attributs ne supportant pas NATIVEMENT le xpath-->
		<facture idfacture="{@numfacture}">
			<xsl:attribute name="nomClient">
				<xsl:variable name="idclientFromFacture" select="@idclient"/>
				<!--recuperation & stockage d'un contenu xml externe au fichier principal-->
				<xsl:variable name="doc_client" select="document( 'clients.xml' )/clients"/>
			</xsl:attribute>
Une facture		
		</facture>
	</xsl:template>
	<!--template echapant le traitement de facture type="devis"-->
	<xsl:template match="facture[contains(@type,'evis')]"/>
</xsl:stylesheet>
