<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="//table[@class=content]/tr/td">
    <xsl:value-of select="."/>
    <!-- <xsl:call-template name="course_outline">
      <xsl:with-param name="table" select="table[position()=#]"/>
    </xsl:call-template> -->
  </xsl:template>

  <xsl:template name="course_outline">
    <xsl:param name="table"/>
  
    
  </xsl:template>
</xsl:stylesheet>