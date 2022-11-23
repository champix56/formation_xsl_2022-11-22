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
			<!--passage de la creation de l'@ttrib par template match sur le noeud qui caracterise la donnée-->
			<xsl:apply-templates select="@idclient"/>
			<prixAvgArticle></prixAvgArticle>
			<ligneAvg></ligneAvg>
			<nbLignes></nbLignes>
		</facture>
	</xsl:template>
	<xsl:template match="@idclient">
		<xsl:attribute name="nomClient">
				<xsl:variable name="idclientFromFacture" select="."/>
				<!--recuperation & stockage d'un contenu xml externe au fichier principal-->
				<xsl:variable name="doc_client" select="document( 'clients.xml' )/clients"/>
				<!--
					correllation entre 2 valeurs issues de 2 arbres xml differents
					!!!privilegiez le parcours direct sans stockage complet de tous larbre externe
					!!! expression complete dans notre cas : document( 'clients.xml' )/clients/client[@id=$idclientFromFacture]
				-->
				<xsl:variable name="un_client_depuis_doc_clients" select="$doc_client/client[@id=$idclientFromFacture]"/>
				<xsl:value-of select="$un_client_depuis_doc_clients/destinataire"/>
			</xsl:attribute>
	</xsl:template>
	<!--template echapant le traitement de facture type="devis"-->
	<xsl:template match="facture[contains(@type,'evis')]"/>
</xsl:stylesheet>
