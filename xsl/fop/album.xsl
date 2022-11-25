<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<!--def.format papier-->
			<fo:layout-master-set>
				<!--
					format simple unique et non conditionnel
					def.des dimensions exterieur du papier
				-->
				<fo:simple-page-master master-name="A4" page-height="297mm" page-width="210mm">
					<!--decl. des regions disponibles-->
					<fo:region-body margin-top="1cm" background-image="{/photos/@theme}"/>
					<fo:region-before extent="1cm"/>
					<fo:region-after extent="5mm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<!--demarage section de pages-->
			<xsl:apply-templates select="//page"/>
		</fo:root>
	</xsl:template>
	<xsl:template match="page">
		<fo:page-sequence master-reference="A4">
			<!--contenu des region automatiquement répliqués sur chaques pages mise en oeuvre par fop pour tout le page-sequence-->
			<fo:static-content flow-name="xsl-region-before">
				<fo:block text-align="center" font-weight="900" font-style="italic">
					<xsl:value-of select="/photos/titre"/>
				</fo:block>
			</fo:static-content>
			<!--flux principal de contenu a mettre en oeuvre dans DES pages-->
			<fo:flow flow-name="xsl-region-body">
				<!--block principal de conteneur structurel fo:flow avec css (text-align)-->
				<fo:block text-align="center">
					<fo:table width="20cm">
						<fo:table-body>
							<fo:table-row height="13cm">
								<xsl:apply-templates select="image[position()&lt;3]"/>
							</fo:table-row>
							<xsl:if test="count(image)>2">
								<fo:table-row height="13cm">
									<xsl:apply-templates select="image[position()&gt;=3]"/>
								</fo:table-row>
							</xsl:if>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	<xsl:template match="page/image">
		<fo:table-cell width="10cm">
			<fo:block text-align="center">
				<fo:external-graphic src="{@path}{@href}" content-height="98mm" content-width="98mm" scaling="uniform"/>
				<fo:block>
					<xsl:value-of select="."/>
				</fo:block>
				<xsl:if test="/photos/@OnlyComment='false'">
					<xsl:value-of select="@href"/>
				</xsl:if>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
	<!--echapement pour les images dont l'extension est SVG pour etre traité en tant que flux xml-->
	<xsl:template match="page/image[   substring(@href,string-length(@href)-2)='svg' ]">
		<fo:table-cell width="10cm">
			<fo:block text-align="center">
				<fo:instream-foreign-object content-height="98mm" content-width="98mm" scaling="uniform">
					<xsl:variable name="docSVG" select="document(concat(@path,@href))/*"/>
					<!--copie complete sans changement de tout le contenu XML de la variable-->
					<xsl:copy-of select="$docSVG"/>
				</fo:instream-foreign-object>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
</xsl:stylesheet>
