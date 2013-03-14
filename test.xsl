<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://www.w3.org/1999/xhtml">

  <xsl:variable name="ws" select="'&#13;&#10;&#09;'"/>
  <xsl:variable name="vDicts" select="document('./tables/dict.xml')/dictionary"/>

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
      <xsl:apply-templates select="h:table[position()=7]" mode="visiting"/>
      <xsl:apply-templates select="h:table[position()=8]" mode="requirements"/>
    </course>
  </xsl:template>

  <!-- ##############################- OUTLINE ########################### -->
  <xsl:template match="h:table" mode="outline">
    <xsl:for-each select="h:tr">
      <xsl:for-each select="h:td[@class='rowhead1']">
        <xsl:apply-templates select="." mode="outline"/>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  <!-- ##############################- REQUIREMENTS ########################### -->  
  <xsl:template match="h:table" mode="requirements">
    <xsl:for-each select="h:tr">
      <xsl:for-each select="h:td[@class='rowhead1']">
        <xsl:apply-templates select="." mode="outline"/>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  <!-- ##############################- VISITING ########################### -->
  <xsl:template match="h:table" mode="visiting">
    <xsl:for-each select="h:tr">
      <xsl:variable name="field" select="h:td[@class='rowhead1']"/>
      <xsl:variable name="field2" select="translate($field, $ws, '')"/>
      <xsl:variable name="elem_name" select="$vDicts/word[@value=$field2]/@dId"/>
      <xsl:element name="{$elem_name}">
        <xsl:value-of select="h:td[@width='85%']"/>       
      </xsl:element>
    </xsl:for-each>
  </xsl:template>
  <!-- ##############################- DELIVER ########################### -->
  <xsl:template match="h:table" mode="delivery">

    <xsl:call-template name="colon_split">
      <xsl:with-param name="cells" select="h:tr[position()=2]"/>
    </xsl:call-template>

    <xsl:variable name="column_names" select="h:tr[position()=3]"/>

    <xsl:variable name="start_activities" select="count($column_names/preceding-sibling::*)"/>
    <xsl:variable name="first_class" select="count(h:tr/h:td[text()='First Class']/../preceding-sibling::*)"/>

    <xsl:for-each select="h:tr[position() &gt; $start_activities and position() &lt; $first_class]">
      <xsl:element name="activity">
        <xsl:for-each select="h:td[position() &lt; 4]">
          <xsl:variable name="index" select="position()"/>
          <xsl:call-template name="row_value">
            <xsl:with-param name="name" select="$column_names/h:td[position()=$index]"/>
          </xsl:call-template>
        </xsl:for-each>
        <xsl:element name="time">
          <xsl:for-each select="h:td[position() &gt; 4]">
            <xsl:variable name="index" select="position()"/>
            <xsl:call-template name="row_value">
              <xsl:with-param name="name" select="$column_names/h:td[position()=$index+4]"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:element>
      </xsl:element>
    </xsl:for-each>

    <xsl:if test="h:tr/h:td[text() = 'First Class']">
      <xsl:variable name="first_class_info" select="h:tr/h:td[text() = 'First Class']/.."/>
      <xsl:element name="first_class">
      <xsl:value-of select="$first_class_info/h:td[@class='data1nobg']"/>        
      </xsl:element>
    </xsl:if>

    <xsl:variable name="outcomes" select="h:tr[last()]/h:td"/>
    <xsl:variable name="outcomes_index" select="count($outcomes/../preceding-sibling::*)"/>

    <xsl:variable name="column_names2" select="h:tr/h:td[text() = 'Exam Diet']/.."/>
    <exam_info>
      <xsl:if test="h:tr/h:td[text() = 'Exam Information']">
        <xsl:variable name="start" select="count($column_names2/preceding-sibling::*)"/>
        <xsl:for-each select="h:tr[position() &gt; $start and position() &lt; $outcomes_index - 2]">

          <xsl:element name="exam">
            <xsl:for-each select="h:td[position() &lt; 4]">
              <xsl:variable name="index" select="position()"/>
              <xsl:variable name="dict" select="$column_names2/h:td[position()=$index]"/>

              <xsl:call-template name="row_value">
                <xsl:with-param name="name" select="$vDicts/word[@value=$dict]/@dId"/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:element>
        </xsl:for-each>

      </xsl:if>
    </exam_info>

    <xsl:element name="learning_outcomes">
      <xsl:value-of select="$outcomes"/>      
    </xsl:element>

  </xsl:template>
  <!-- ##############################- ASSESSMENT ########################### -->
  <xsl:template match="h:table" mode="assessment">
    <assessment>
      <xsl:value-of select="h:tr/h:td"/>
    </assessment>
  </xsl:template>
  <!-- ##############################- SPECIAL ########################### -->
  <xsl:template match="h:table" mode="special">
    <special_arrangements>
      <xsl:value-of select="h:tr/h:td"/>
    </special_arrangements>
  </xsl:template>
  <!-- ##############################- ADDITIONAL ########################### -->
  <xsl:template match="h:table" mode="additional">
    additional
  </xsl:template>
  <!-- ##############################- CONTACTS ########################### -->
  <xsl:template match="h:table" mode="contacts">
    contacts
  </xsl:template>

  <!-- ##############################- HELP FUNCTIONS ########################### -->
  <xsl:template match="h:td" mode="outline">
    <xsl:variable name="no_ws" select="translate(text(), $ws, '')"/>
    <xsl:variable name="elem_name" select="$vDicts/word[@value=$no_ws]/@dId"/>
    <xsl:element name="{$elem_name}">
      <xsl:value-of select="./following-sibling::h:td"/>
    </xsl:element>
  </xsl:template>


  <xsl:template name="row_value">
    <xsl:param name="name" />
    <xsl:element name="{$name}">
      <xsl:value-of select="text()"/>
    </xsl:element>
  </xsl:template>


  <xsl:template match="h:tr">
    <xsl:for-each select="h:td">
      <xsl:variable name="index" select="position()"/>
      <xsl:value-of select="text()"/> - <xsl:value-of select="$column_names/h:td[position()=$index]"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="colon_split">
    <xsl:param name="cells" />
    <xsl:for-each select="$cells/h:td">
      <xsl:variable name="pronto" select="translate(text(), $ws, '')"/>
      <xsl:if test="contains($pronto, ':')">
        <xsl:variable name="before" select="substring-before($pronto, ':')"/>
        <xsl:variable name="after" select="substring-after($pronto, ':')"/>
        <xsl:variable name="elem_name" select="$vDicts/word[@value=$before]/@dId"/>
        <xsl:element name="{$elem_name}">
          <xsl:value-of select="$after"/>
        </xsl:element>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>