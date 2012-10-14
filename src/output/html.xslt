<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xdmp="http://marklogic.com/xdmp"
                version="2.0"
                exclude-result-prefixes="xdmp">

  <xsl:output method="html" omit-xml-declaration="yes" indent="yes"/>

  <xsl:template match="coverage">
    <html>
    <head>
      <title>Blanket - Coverage <xsl:value-of select="@percentage"/>%</title>
      <xsl:call-template name="style"/>
    </head> 
    <body>
      <h1>Coverage <xsl:value-of select="@percentage"/>%</h1>
      <p id="reset"><a href="reset.xqy">reset</a></p>
      <ul>
        <xsl:for-each select="module">
          <xsl:sort select="number(@percentage)"/>
          <xsl:apply-templates select="."/>
        </xsl:for-each> 
      </ul>
    </body>
    </html>
  </xsl:template>

  <xsl:template match="module">
    <li>
      <xsl:value-of select="@uri"/>&#160;(<xsl:value-of select="@percentage"/>%)
      <ul>
        <xsl:apply-templates/>
      </ul>
    </li>
  </xsl:template>

  <xsl:template match="function">
    <li>
      <xsl:attribute name="class"><xsl:if test="@covered = 'false'">not-</xsl:if>covered</xsl:attribute>
      <xsl:value-of select="@name"/>&#160;(<xsl:value-of select="@start"/>)
    </li>
  </xsl:template>

  <xsl:template name="style">
    <style type="text/css">
      body { font-family: "Courier New",Sans-serif; }
      h1 { margin: 10px 0 0 0; }
      ul { margin-left: 0; padding-left: 0; }
      li { list-style-type: none; padding: 0; margin-left: 0; }
      ul li {  border: 1px solid #666; margin-bottom: 10px; padding: 5px; }
      ul li ul { padding-left: 20px; border: 0; padding-top: 5px; }
      ul li ul li { border: 0; padding: 0; }
      li.covered { color: green; }
      li.not-covered { color: red; }
      #reset { position: absolute; top: 10px; right: 10px; }
    </style>
  </xsl:template>

</xsl:stylesheet>