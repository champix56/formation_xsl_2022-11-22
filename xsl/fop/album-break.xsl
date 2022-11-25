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
				<fo:simple-page-master master-name="A4odd" page-height="297mm" page-width="210mm">
					<!--decl. des regions disponibles-->
					<fo:region-body margin-top="1cm" background-image="{/photos/@theme}" margin-right="1cm"/>
					<fo:region-before extent="1cm"/>
					<fo:region-after extent="5mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="A4even" page-height="297mm" page-width="210mm">
					<!--decl. des regions disponibles-->
					<fo:region-body margin-top="1cm" background-image="{/photos/@theme}" margin-left="1cm"/>
					<fo:region-before extent="1cm"/>
					<fo:region-after extent="5mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="A4Couv" page-height="297mm" page-width="210mm">
					<fo:region-body background-image="{/photos/@theme}"/>
				</fo:simple-page-master>
				<!--format conditionnel-->
				<fo:page-sequence-master master-name="A4Conditionnel">
					<fo:repeatable-page-master-alternatives>
						<!--1ere page du page sequence utilisant ce format-->
						<fo:conditional-page-master-reference master-reference="A4Couv" page-position="first"/>
						<!--pour tous le reste du document avec page pair(odd) et page impair(even)-->
						<fo:conditional-page-master-reference master-reference="A4odd" page-position="rest" odd-or-even="even"/>
						<fo:conditional-page-master-reference master-reference="A4even" page-position="rest" odd-or-even="odd"/>
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<!--demarage section de pages-->
			<fo:page-sequence master-reference="A4Conditionnel">
				<!--contenu des region automatiquement répliqués sur chaques pages mise en oeuvre par fop pour tout le page-sequence-->
				<fo:static-content flow-name="xsl-region-before">
					<fo:block text-align="center" font-weight="900" font-style="italic">
						<xsl:value-of select="/photos/titre"/>
					</fo:block>
				</fo:static-content>
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<xsl:apply-templates select="//couv"/>
						<xsl:apply-templates select="//page"/>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template match="couv">
		<fo:block text-align="center" break-after="page">
			<fo:block color="skyblue" font-size="32pt" margin-bottom="4cm" margin-top="6cm">
				<xsl:value-of select="/photos/titre"/>
			</fo:block>
			<fo:external-graphic scaling="uniform" src="{image/@path}{image/@href}" content-height="10cm" content-width="20cm"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="page">
		<!--block principal de conteneur structurel fo:flow avec css (text-align)-->
		<fo:block text-align="center" break-after="page">
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
