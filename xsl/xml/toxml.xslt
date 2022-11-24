<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:apply-templates select="factures"/>
	</xsl:template>
	<xsl:template match="*">
		<!--
				fabrique un noeud element (balise) en sortie, ici avec un nom reprenant le nom du noeud en cours avec un prefix
				xsl:element necessite l'usage de xsl:attribute pour les attribut de la balise creer en sortie
		-->
		<xsl:element name="stat-{name()}">
			<xsl:apply-templates select="./*"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="@*">
		<!--name() permet de recuperer le nom du noeud en cours de context (noeud dans lequel on est placé-->
		<xsl:attribute name="stat-{name()}"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
	<xsl:template match="facture">
		<!--xpath dans des attributs ne supportant pas NATIVEMENT le xpath-->
		<facture idfacture="{@numfacture}">
			<!--passage de la creation de l'@ttrib par template match sur le noeud qui caracterise la donnée-->
			<!--declenchement de tous les @ttrib sans exception, le template le plus aproprié sera declenché
					soit @idclient soit @* si aucun autre template specifique declarer-->
			<xsl:apply-templates select="@*"/>
			<prixAvgArticle><xsl:value-of select="sum(.//phtByUnit) div count(.//phtByUnit)"/></prixAvgArticle>
			<ligneAvg><xsl:value-of select="sum(.//stotligne) div count(.//stotligne)"/></ligneAvg>
			<nbLignes><xsl:value-of select="count(.//ligne)"/></nbLignes>
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
