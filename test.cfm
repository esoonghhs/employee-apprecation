<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
<script language = "Javascript">

function LimitThis() {
	var myObject=event.srcElement;
	if (myObject.value.length==myObject.maxLength*1) return false;
}

function CountThis(visCnt) { 
	var myObject=event.srcElement;
	if (myObject.value.length>myObject.maxLength*1) myObject.value=myObject.value.substring(0,myObject.maxLength*1);
	if (visCnt) visCnt.innerText=myObject.maxLength-myObject.value.length;
	
}
</script>
	
</head>

<body>

<font face=verdana,arial,helvetica size=1>

<p><strong>Description</strong><br>
<textarea name="Description" cols="50" rows="6" id="Description"  onkeypress="return LimitThis()" onkeyup="return CountThis(myCounter1)" onmouseover="return CountThis(myCounter1)" wrap=physical maxLength="500"></textarea>
<br><font color=#666666>(500 characters max.) <strong><SPAN id=myCounter1>500</SPAN></strong> remaining</font>

<p><strong>Experience</strong><br>
<textarea name="Experience" cols="50" rows="6" id="Experience" onkeypress="return LimitThis()" onkeyup="return CountThis(myCounter2)" onmouseover="return CountThis(myCounter2)" wrap=physical maxLength="250"></textarea>
<br>
<font color=#333333>(250 characters max.) <strong><SPAN id=myCounter2>250</SPAN></strong> remaining</font>

</font>

</body>
</html>
