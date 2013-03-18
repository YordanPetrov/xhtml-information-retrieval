<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output
    method="html" 
    version="1.0" 
    encoding="UTF-8" 
    indent="yes"/>

  <xsl:variable name="ws" select="'&#13;&#10;&#09;'"/>
  <xsl:variable name="vDicts" select="document('./tables/dict.xml')/dictionary"/>
  <xsl:template match="/">
    <html>
      <body>
        <xsl:for-each select="course">
          <h1><xsl:value-of select="title"/></h1>

          <xsl:for-each select="./*[position() &gt; 1]">
            <xsl:call-template name="simple_table"/>
          </xsl:for-each>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="course">
    <h1><xsl:value-of select="title"/></h1>

    <xsl:for-each select="./*">
      <xsl:call-template name="simple_table"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="simple_field">
    <xsl:variable name="field_name" select="name(.)"/>
    <tr>
      <td width="30%">
        <xsl:value-of select="$vDicts/word[@dId=$field_name]/@value"/>
      </td>
        <xsl:if test="count(./*) = 0">
          <td width="70%">
            <xsl:value-of select="text()"/>
          </td>
        </xsl:if>
        <xsl:if test="count(./*) > 0">
          <td width="70%">
            <table border="1">
              <tr>
                <xsl:for-each select="./*">
                  <td>
                    <xsl:value-of select="name(.)"/>
                  </td>
                </xsl:for-each>        
              </tr>
              <tr>
                <xsl:for-each select="./*">
                  <xsl:if test="count(./*) = 0">
                    <td >
                      <xsl:value-of select="text()"/>
                    </td>
                  </xsl:if>
                  <xsl:if test="count(./*) > 0">
                    <xsl:call-template name="horizontal_field"/>
                  </xsl:if>
                </xsl:for-each>        
              </tr>
            </table>
          </td>
        </xsl:if>
    </tr>
  </xsl:template>

  <xsl:template name="horizontal_field">
    <td>
      <xsl:for-each select="./*">
        <xsl:if test="text() != ''">
          <xsl:value-of select="name(.)"/> - <xsl:value-of select="text()"/> |
        </xsl:if>
      </xsl:for-each>
    </td>
  </xsl:template>  

  <xsl:template name="simple_table">
    <xsl:variable name="table_name_temp" select="name(.)"/>
    <xsl:variable name="table_name" select="normalize-space($vDicts/word[@dId=$table_name_temp]/@value)"/>

    <table border="1" style="border:1px solid black;" width="100%">
      <tr>
        <td>
          <h2><xsl:value-of select="translate($table_name, $ws, '')"/></h2>
        </td>
      </tr>
      <xsl:if test="count(./*) = 0">
        <tr><td><xsl:value-of select="text()"/></td></tr>
      </xsl:if>
      <xsl:for-each select="./*">
        <xsl:call-template name="simple_field"/>
      </xsl:for-each>
    </table>
  </xsl:template>

</xsl:stylesheet>