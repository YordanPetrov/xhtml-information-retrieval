<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output
  method="html" 
  version="1.0" 
  encoding="UTF-8" 
  indent="yes"/>

  <xsl:template match="/">
    <xsl:for-each select="course">
      <xsl:apply-templates/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="course">
    <html>
      <body>
        <h1><xsl:value-of select="title"/></h1>
        <xsl:for-each select="./*">
          <xsl:apply-templates/>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

  <!-- ############## outline ############### -->
  <xsl:template match="outline">
    outline
  </xsl:template>

  <!-- ############## entry_requirements ############### -->
  <xsl:template match="entry_requirements">
    entry_requirements
  </xsl:template>

  <!-- ############## vs_info ############### -->
  <xsl:template match="vs_info">
    vs_info
  </xsl:template>

  <!-- ############## delivery_info ############### -->
  <xsl:template match="delivery_info">
    delivery_info
  </xsl:template>

  <!-- ############## learning_outcomes ############### -->
  <xsl:template match="learning_outcomes">
    learning_outcomes
  </xsl:template>

  <!-- ############## assessment ############### -->
  <xsl:template match="assessment">
    assessment
  </xsl:template>

  <!-- ############## special_arrangements ############### -->
  <xsl:template match="special_arrangements">
    special_arrangements
  </xsl:template>

  <!-- ############## additional_info ############### -->
  <xsl:template match="additional_info">
    additional_info
  </xsl:template>

  <!-- ############## contacts ############### -->
  <xsl:template match="contacts">
    contacts
  </xsl:template>

</xsl:stylesheet>