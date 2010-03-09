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
else
{ 
 gkey = "ABQIAAAAMunL2PF_-ibJlwJr-tMA8RTkFTU-bOiazHtZ0nNnypynHqSO4hRZnPrnn0_VUhIEMt-cWpvnGi2-Kg";
}
tag = "<scr" + "ipt src=\"http://maps.google.com/maps?file=api&amp;v=2&amp;key="+gkey+"\" type=\"text/javascript\"></scr" + "ipt>";

