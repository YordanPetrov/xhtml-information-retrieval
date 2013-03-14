<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://www.w3.org/1999/xhtml">

  <xsl:template match="/h:html">
    <!-- <xsl:value-of select="table[position()=-1]"/> -->
    <!-- <xsl:apply-templates select="html/body/table"/> -->
    <xsl:apply-templates select="h:body/h:table[position()=2]/h:tr/h:td[position()=1]"/>
  </xsl:template>

  <xsl:template match="h:td">
    <course>
      <xsl:apply-templates select="h:table[position()=1]" mode="outline"/>
      <xsl:apply-templates select="h:table[position()=2]" mode="requirements"/>
      <xsl:apply-templates select="h:table[position()=3]" mode="visiting"/>
      <xsl:apply-templates select="h:table[position()=4]" mode="delivery"/>
      <xsl:apply-templates select="h:table[position()=5]" mode="assessment"/>
      <xsl:apply-templates select="h:table[position()=6]" mode="special"/>
      <xsl:apply-templates select="h:table[position()=7]" mode="additional"/>
      <xsl:apply-templates select="h:table[position()=8]" mode="contacts"/>
    </course>
  </xsl:template>

  <xsl:template match="h:table" mode="outline">
    outline
  </xsl:template>
  <xsl:template match="h:table" mode="requirements">
    requirements
  </xsl:template>
  <xsl:template match="h:table" mode="visiting">
    visiting
  </xsl:template>
  <xsl:template match="h:table" mode="delivery">
    delivery
  </xsl:template>
  <xsl:template match="h:table" mode="assessment">
    assessment
  </xsl:template>
  <xsl:template match="h:table" mode="special">
    special
  </xsl:template>
  <xsl:template match="h:table" mode="additional">
    additional
  </xsl:template>
  <xsl:template match="h:table" mode="contacts">
    contacts
  </xsl:template>
</xsl:stylesheet>