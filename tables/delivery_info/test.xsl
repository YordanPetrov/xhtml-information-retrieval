<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="pFrom" select="'en'"/>
  <xsl:param name="pTo" select="'de'"/>

  <xsl:variable name="vDicts" select="document('../dict.xml')/dictionary"/>
  <xsl:key name="htmlToXml" match="@dId" use="@value"/>

  <xsl:variable name="uc" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="lc" select="'abcdefghijklknopqrstuvwxyz_'"/>
  <!-- <xsl:variable name="ws" select="' &#13;&#10;&#09;()?'"/> -->
  <xsl:variable name="ws" select="'&#13;&#10;&#09;'"/>
  
  <xsl:template match="/table">
    <xsl:variable name="column_names" select="tr[position()=1]"/>

    <xsl:for-each select="tr[position() &gt; 1]">
      <xsl:element name="activity">
        <xsl:for-each select="td[position() &lt; 5]">
          <xsl:variable name="index" select="position()"/>
          <xsl:call-template name="row_value">
            <xsl:with-param name="name" select="$column_names/td[position()=$index]"/>
          </xsl:call-template>
        </xsl:for-each>
        
        <xsl:text>&#xa;</xsl:text>

        <xsl:element name="time">
          <xsl:for-each select="td[position() &gt; 4]">
            <xsl:variable name="index" select="position()"/>
            <xsl:call-template name="row_value">
              <xsl:with-param name="name" select="$column_names/td[position()=$index+4]"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:element>

      </xsl:element>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="row_value">
    <xsl:param name="name" />
    <xsl:element name="{$name}">
      <xsl:value-of select="text()"/>
    </xsl:element>
  </xsl:template>


  <xsl:template match="tr">
    <xsl:for-each select="td">
      <xsl:variable name="index" select="position()"/>
      <xsl:value-of select="text()"/> - <xsl:value-of select="$column_names/td[position()=$index]"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="row_value">
    <xsl:param name="name" />
    <xsl:element name="{$name}">      
      <xsl:value-of select="text()"/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>

<!-- 
      <xsl:if test="contains($pronto, ':')">
        <xsl:variable name="before" select="substring-before($pronto, ':')"/>
        <xsl:variable name="after" select="substring-after($pronto, ':')"/>
        <xsl:value-of select="$before"/> - <xsl:value-of select="$after"/>
      </xsl:if>
      <xsl:value-of select="$pronto"/> - <xsl:value-of select="$elem_name"/>

      
      <xsl:if test="$pronto = 'No Exam Information'">
        <xsl:value-of select="$pronto"/>
      </xsl:if>
       -->
