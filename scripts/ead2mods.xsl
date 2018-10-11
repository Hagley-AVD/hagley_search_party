<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"
      encoding="UTF-8" media-type="text/xml; charset=UTF-8"
      omit-xml-declaration="no"/>
	  <xsl:strip-space elements="*"/>
<xsl:template match="text()"/>
<xsl:template match="/ead/archdesc[@level='collection']/did">
<mods xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
<titleInfo><title><xsl:value-of select="unittitle"/></title></titleInfo>
<xsl:if test="origination">
                              <xsl:for-each select="origination">
                                <xsl:choose>
                                  <xsl:when test="./persname">
                                    <name type="personal">
                                      <namePart>
                                        <xsl:value-of select="."/>
                                      </namePart>
									                                  <xsl:if test="./@label">
                                  <role>
                                    <roleTerm type="text">
                                      <xsl:value-of select="./@label"/>
                                    </roleTerm>
                                  </role>
                                </xsl:if>
                                    </name>
                                  </xsl:when>
                                  <xsl:when test="./corpname">
                                    <name type="corporate">
                                      <namePart>
                                        <xsl:value-of select="."/>
                                      </namePart>
									                                  <xsl:if test="./@label">
                                  <role>
                                    <roleTerm type="text">
                                      <xsl:value-of select="./@label"/>
                                    </roleTerm>
                                  </role>
                                </xsl:if>
                                    </name>
                                  </xsl:when>
                                  <xsl:when test="./famname">
                                    <name type="family">
                                      <namePart>
                                        <xsl:value-of select="."/>
                                      </namePart>
									                                  <xsl:if test="./@label">
                                  <role>
                                    <roleTerm type="text">
                                      <xsl:value-of select="./@label"/>
                                    </roleTerm>
                                  </role>
                                </xsl:if>
                                    </name>
                                  </xsl:when>
                                  <xsl:when test="./confname">
                                    <name type="conference">
                                      <namePart>
                                        <xsl:value-of select="."/>
                                      </namePart>
									                                  <xsl:if test="./@label">
                                  <role>
                                    <roleTerm type="text">
                                      <xsl:value-of select="./@label"/>
                                    </roleTerm>
                                  </role>
                                </xsl:if>
                                    </name>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <name>
                                      <namePart>
                                        <xsl:value-of select="."/>
                                      </namePart>
									                                  <xsl:if test="./@label">
                                  <role>
                                    <roleTerm type="text">
                                      <xsl:value-of select="./@label"/>
                                    </roleTerm>
                                  </role>
                                </xsl:if>
                                    </name>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:for-each>
                            </xsl:if>
<recordInfo><recordIdentifier><xsl:value-of select="unitid"/></recordIdentifier></recordInfo>
<typeOfResource>mixed material</typeOfResource>
</mods>
</xsl:template>
</xsl:stylesheet>
