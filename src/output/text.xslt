<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xdmp="http://marklogic.com/xdmp"
                version="2.0"
                exclude-result-prefixes="xdmp">

  <xsl:output method="text" omit-xml-declaration="yes" indent="yes"/>

  <xsl:template match="coverage">Coverage <xsl:value-of select="@percentage"/>%<xsl:text>&#10;</xsl:text><xsl:if test="@percentage != '0'"><xsl:apply-templates/></xsl:if>
  </xsl:template>


  <xsl:template match="module">
    <xsl:if test="@percentage != '100'"><xsl:value-of select="@uri"/>&#160;(<xsl:value-of select="@percentage"/>%)<xsl:text>&#10;</xsl:text><xsl:apply-templates/></xsl:if>
  </xsl:template>

  <xsl:template match="function">
    <xsl:if test="@covered = 'false'">&#160;&#160;<xsl:value-of select="@name"/>&#160;(<xsl:value-of select="@start"/>)<xsl:text>&#10;</xsl:text></xsl:if>
  </xsl:template>

</xsl:stylesheet>