<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="vDicts" select="document('../dict.xml')/dictionary"/>
  <xsl:variable name="ws" select="'&#13;&#10;&#09;'"/>
  
  <xsl:template match="/table">
    <xsl:call-template name="colon_split">
      <xsl:with-param name="cells" select="tr[position()=2]"/>
    </xsl:call-template>

    <xsl:variable name="column_names" select="tr[position()=3]"/>

    <xsl:variable name="start_activities" select="count($column_names/preceding-sibling::*)"/>
    <xsl:variable name="first_class" select="count(tr/td[text()='First Class']/../preceding-sibling::*)"/>

    <xsl:for-each select="tr[position() &gt; $start_activities and position() &lt; $first_class]">
      <xsl:element name="activity">
        <xsl:for-each select="td[position() &lt; 4]">
          <xsl:variable name="index" select="position()"/>
          <xsl:call-template name="row_value">
            <xsl:with-param name="name" select="$column_names/td[position()=$index]"/>
          </xsl:call-template>
        </xsl:for-each>
        <xsl:element name="time">
          <xsl:for-each select="td[position() &gt; 4]">
            <xsl:variable name="index" select="position()"/>
            <xsl:call-template name="row_value">
              <xsl:with-param name="name" select="$column_names/td[position()=$index+4]"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:element>
        <xsl:text>&#xa;</xsl:text>
      </xsl:element>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>

    <xsl:if test="tr/td[text() = 'First Class']">
      <xsl:variable name="first_class_info" select="tr/td[text() = 'First Class']/.."/>
      <xsl:element name="first_class">
      <xsl:value-of select="$first_class_info/td[@class='data1nobg']"/>        
      </xsl:element>
    </xsl:if>


    <xsl:variable name="column_names2" select="tr/td[text() = 'Exam Diet']/.."/>

    <xsl:if test="tr/td[text() = 'Exam Information']">
      <xsl:variable name="start" select="count($column_names2/preceding-sibling::*)"/>
      <xsl:for-each select="tr[position() &gt; $start and position() &lt; 12]">

        <xsl:element name="exam">
          <xsl:for-each select="td[position() &lt; 4]">
            <xsl:variable name="index" select="position()"/>
            <xsl:variable name="dict" select="$column_names2/td[position()=$index]"/>

            <xsl:call-template name="row_value">
              <xsl:with-param name="name" select="$vDicts/word[@value=$dict]/@dId"/>
            </xsl:call-template>
          </xsl:for-each>
          <xsl:text>&#xa;</xsl:text>
        </xsl:element>
        <xsl:text>&#xa;</xsl:text>
      </xsl:for-each>

    </xsl:if>

    <xsl:variable name="outcomes" select="//tr[last()]"/>
    <xsl:element name="learning_outcomes">
      <xsl:value-of select="$outcomes"/>      
    </xsl:element>
  

  </xsl:template>

  <xsl:template name="row_value">
    <xsl:param name="name" />
    <xsl:element name="{$name}">
      <xsl:value-of select="text()"/>
    </xsl:element>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>


  <xsl:template match="tr">
    <xsl:for-each select="td">
      <xsl:variable name="index" select="position()"/>
      <xsl:value-of select="text()"/> - <xsl:value-of select="$column_names/td[position()=$index]"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="colon_split">
    <xsl:param name="cells" />
    <xsl:for-each select="$cells/td">
      <xsl:variable name="pronto" select="text()"/>
      <xsl:if test="contains($pronto, ':')">
        <xsl:variable name="before" select="substring-before($pronto, ':')"/>
        <xsl:variable name="after" select="substring-after($pronto, ':')"/>
        <xsl:variable name="elem_name" select="$vDicts/word[@value=$before]/@dId"/>
        <xsl:element name="{$elem_name}">
          <xsl:value-of select="$after"/>
        </xsl:element>
        <xsl:text>&#xa;</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
