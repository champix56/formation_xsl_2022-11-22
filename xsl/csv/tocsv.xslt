<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="UTF-8" indent="no"/>
	<!-- 
		methode de presentation pour le noeud '/'
		declenchée automatiquement
		point de depart de la transfo
	-->
	<xsl:template match="/">
		<xsl:value-of select=" 'numero de facture;date facture;idclient;nb de ligne;montant total ht;montant tva;montant ttc;' "/>
<!--preservation du contenu textuelle avec ou sans caracteres affichable dans la balise xsl text 
!!!!!seul un saut de ligne sans espace est présent ici dans la balise text!!!!!! 
-->
<xsl:text>
</xsl:text>
		<xsl:for-each select="//facture">
			<xsl:value-of select="concat(@numfacture,';')"/>
			<xsl:value-of select="concat(@datefacture,';')"/>
			<xsl:value-of select="concat(@idclient,';')"/>
			<xsl:value-of select="concat(count(.//ligne),';')"/>
			<!--appel explicit d'un template possedant un name=""-->
			<xsl:call-template name="calcul-totaux">
				<!--appel avec un param existant et declaré dans le template-->
				<xsl:with-param name="total_ht" select="sum(.//stotligne)"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<!--
	equivalant a une methode dans d'autres languages
	explicitement appelée par <xsl:call-template name="calcul-totaux"/>
-->
	<xsl:template name="calcul-totaux">
		<!--def d'un parametre d'entree a fournir lors de l'appele-->
		<xsl:param name="total_ht"/>
		<!--precalcul dans des espaces memoire pour reutilisation-->
		<xsl:variable name="rounded_totalht" select="round($total_ht*100) div 100"/>
		<xsl:variable name="rounded_totaltva" select="round($rounded_totalht* 20) div 100"/>
		<!--expression des variables-->
		<xsl:value-of select="$rounded_totalht"/>;<xsl:value-of select="$rounded_totaltva"/>;<xsl:value-of select="$rounded_totaltva + $rounded_totalht"/>;
</xsl:template>
</xsl:stylesheet>
