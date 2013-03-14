<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="vDicts" select="document('../dict.xml')/dictionary"/>
  <xsl:variable name="ws" select="'&#13;&#10;&#09;'"/>
  
  <xsl:template match="/table">
  	<xsl:for-each select="tr">
  		<xsl:variable name="field" select="td[@class='rowhead1']"/>
      <xsl:variable name="field2" select="translate($field, $ws, '')"/>
  		<xsl:variable name="elem_name" select="$vDicts/word[@value=$field2]/@dId"/>
       <xsl:element name="{$elem_name}">
		  	<xsl:value-of select="td[@width='85%']"/>  			
  		 </xsl:element>  		
  	</xsl:for-each>
	</xsl:template>  

</xsl:stylesheet>
