<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="pFrom" select="'en'"/>
  <xsl:param name="pTo" select="'de'"/>

  <!-- <xsl:key name="kIdByLangVal" match="@dId" use="concat(../../@lang, '+', ../@value)"/> -->

  <!-- <xsl:key name="kValByLangId" match="@value" use="concat(../../@lang, '+', ../@dId)"/> -->

  <xsl:variable name="vDicts" select="document('../dict.xml')/dictionary"/>

  <xsl:variable name="ws" select="'&#13;&#10;&#09;'"/>
  <xsl:template match="/table">
    <xsl:for-each select="tr">
      <xsl:for-each select="td[@class='rowhead1']">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="td">
    <xsl:variable name="no_ws" select="translate(text(), $ws, '')"/>
    <xsl:variable name="elem_name" select="$vDicts/word[@value=$no_ws]/@dId"/>
    <xsl:element name="{$elem_name}">
      <xsl:value-of select="./following-sibling::td"/>
    </xsl:element>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

</xsl:stylesheet>