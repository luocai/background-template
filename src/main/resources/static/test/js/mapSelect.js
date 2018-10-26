// JavaScript Document
function mapSelect(map){
	var maps=document.getElementsByClassName("maps");
	for(var i=0;i< maps.length;i++){
		var m=maps[i];
		if(m.getAttribute("id")!=map){
			m.style.display="none";
		}
		else{
			m.style.display="block";
		}
	}
}
function descSelect(desc){
	var descs=document.getElementsByClassName("descs");
	for(var i=0;i< descs.length;i++){
		var d=descs[i];
		if(d.getAttribute("id")!=desc){
			d.style.display="none";
		}
		else{
			d.style.display="block";
		}
	}
}