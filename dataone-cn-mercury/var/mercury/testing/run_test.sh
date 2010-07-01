# the first script produces TAP output (ok / not_ok)
# the second converts it to JUnit / ANT output format
# that should be suitable for Hudson.
perl ./test_xpath_v_sampleData.pl | perl ./tap-to-junit-xml.pl --puretap > t_outputs/xpathFind_v_sampleData.xml