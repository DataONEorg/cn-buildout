var curlocation = location.href;

if(curlocation.indexOf("http://metadata.nbii.gov")!=-1)
{
 gkey = "ABQIAAAAMunL2PF_-ibJlwJr-tMA8RRDKhQxe_HgJHG-OYZxjRlm45-1SBRIQRr8vCQTyEbnPy8K2S9o5rddGw";
}
else if(curlocation.indexOf("http://mercdev3.ornl.gov")!=-1)
{
	gkey = "ABQIAAAAMunL2PF_-ibJlwJr-tMA8RQx4LHPm-99MtH4qsU57UOlk9_xkxTvQ5m6O1j-LhA0ksaDR80nWSFugQ";
}
else if(curlocation.indexOf("http://cn-dev.dataone.org")!=-1)
{
	gkey = "ABQIAAAAhu7ZzoapDAMojvQIlFWa2xRTgBbIYGV_NA3GDkHAhutlDymbaBT18vYRvirplXlJthkQmYQPEwM_Ng";
}
else if(curlocation.indexOf("http://devportal.nbii.gov")!=-1)
{
	gkey = "ABQIAAAAMunL2PF_-ibJlwJr-tMA8RQLuipRujvM7qWlxjrJnIe2s1oi8xTSFwtaQrDYa8ye7QCQV79PJBQcQg";
}
else if(curlocation.indexOf("http://mercury-dev.ornl.gov")!=-1)
{
	gkey = "ABQIAAAAMunL2PF_-ibJlwJr-tMA8RTNxbzXnsENtbbDkSg7-muyOrR_TRSySze0ZLAWEg_-rmxiGmamVdH8XA";
}
else if(curlocation.indexOf("http://daacrd.ornl.gov")!=-1)
{
	gkey = "ABQIAAAAlS3JK-ZqWSF9DvlsVuKDyBRZk5Wg-W_mx71Gu3Eqp75BLb0HBhTkCPsJ5PaTBqA7Z2UN-MQwLoJ76w";
}
else if(curlocation.indexOf("http://cn-ucsb-1.dataone.org") != -1)
{
  gkey = "ABQIAAAAuYWC81lXHUzQz1QJga3l8hR3ud-BIj7E0PLxOb5nKvE6iYKfchRZSstsTbW5r5h83q7b8WThhfo86A";
}
else if(curlocation.indexOf("https://cn-ucsb-1.dataone.org") != -1)
{
  gkey= "ABQIAAAAuYWC81lXHUzQz1QJga3l8hQUb57AQDWF3gXz_wkYvsKZ-k61iBRLXQo3LMPwbAoG5fqsXAIxDzErlA";
}
else if(curlocation.indexOf("http://cn-unm-1.dataone.org") != -1)
{
  gkey = "ABQIAAAAuYWC81lXHUzQz1QJga3l8hSS04c4NbGTDqdmpwFWLo7aT0wv0xQUqNfrRjXMkW4z87Wn38Zpy4KIVg";
}
else if(curlocation.indexOf("https://cn-unm-1.dataone.org") != -1)
{
  gkey = "ABQIAAAAuYWC81lXHUzQz1QJga3l8hRWIrNTuCbEx05ophev7c1W3ouGRhTtM-1u79uYQKSATPuTZke6YIqWrw";
}
else if(curlocation.indexOf("http://cn-orc-1.dataone.org") != -1)
{
  gkey = "ABQIAAAAuYWC81lXHUzQz1QJga3l8hSSDrPAcYjZlkF6Tkq3u_Fyu3mCCxSQYYUlOrQcODgjecV1RvXjMXhfAQ";
}
else if(curlocation.indexOf("https://cn-orc-1.dataone.org") != -1)
{
  gkey = "ABQIAAAAuYWC81lXHUzQz1QJga3l8hS9CQhLdweL4ZrWjfnREsyw3-D2MBS2oNic6rT2O8nRebgmlFHYO7jXdA";
}
else
{
 //gkey = "ABQIAAAAMunL2PF_-ibJlwJr-tMA8RTkFTU-bOiazHtZ0nNnypynHqSO4hRZnPrnn0_VUhIEMt-cWpvnGi2-Kg";
  //default key is for "http://cn.dataone.org"
  if (curlocation.indexOf("https") != -1)
  {
    gkey = "ABQIAAAAuYWC81lXHUzQz1QJga3l8hS32z3uD4iXEFe3y5W1m7CylJ-VRhTeiGZCafxMWGQEyDrj0j8chBa2Dw";
  }
  else
  {
    gkey = "ABQIAAAAuYWC81lXHUzQz1QJga3l8hQeSVgniQmrIwOXFpLeToaRJdxWixSppZ3XA2lcOViCzbkUYKuLuhXaWg";
  }
}
tag = "<scr" + "ipt src=\"http://maps.google.com/maps?file=api&amp;v=2&amp;key="+gkey+"\" type=\"text/javascript\"></scr" + "ipt>";

