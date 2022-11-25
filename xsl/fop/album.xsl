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
					<fo:region-body margin-top="1cm"/>
					<fo:region-before extent="1cm" />
					<fo:region-after extent="5mm"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<!--demarage section de pages-->
			<fo:page-sequence master-reference="A4">
			<!--contenu des region automatiquement répliqués sur chaques pages mise en oeuvre par fop pour tout le page-sequence-->
				<fo:static-content flow-name="xsl-region-before">
					<fo:block text-align="center" font-weight="900" font-style="italic"><xsl:value-of select="/photos/titre"/></fo:block>
				</fo:static-content>
				<!--flux principal de contenu a mettre en oeuvre dans DES pages-->
				<fo:flow flow-name="xsl-region-body">
					<!--block principal de conteneur structurel fo:flow avec css (text-align)-->
					<fo:block text-align="center">
						<fo:block break-after="page">
							Bonjour <fo:inline color="blue">le</fo:inline> monde
						</fo:block>
						<fo:block break-after="page">
							DEMAT <fo:inline color="tomato">Breizh</fo:inline>
						</fo:block>
						<fo:block>
							Hello <fo:inline color="orange" text-decoration="underline">World</fo:inline>
						</fo:block>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
