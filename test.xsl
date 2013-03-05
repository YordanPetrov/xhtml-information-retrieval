<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/root">
    <xsl:for-each select="tr">
      <xsl:for-each select="td[@class='rowhead1']">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="td">
    <xsl:element name="{text()}">
      <xsl:value-of select="./following-sibling::td"/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>