
Ti.UI.setBackgroundColor('#000');

var PDF = require('bencoding.pdf');
Ti.API.info("module is => " + PDF);

var converters = PDF.createConverters();

var win = Ti.UI.createWindow({  
	title:'PDF Screenshot', backgroundColor:'#fff'
});

var vwContent = Ti.UI.createView({
	top:0, layout:'vertical'
});
win.add(vwContent);

var row1 = Ti.UI.createView({
	height:100, backgroundColor:'blue',width:Ti.UI.FILL
});
vwContent.add(row1);

row1.add(Ti.UI.createLabel({
	color:'#fff',text:"Hello", width:Ti.UI.FILL, height:Ti.UI.FILL, font:{fontSize:24}	
}));

var row2 = Ti.UI.createView({
	height:610, backgroundColor:'red', width:Ti.UI.FILL
});
vwContent.add(row2);

row2.add(Ti.UI.createLabel({
	color:'#000',text:"Hi", width:Ti.UI.FILL, height:Ti.UI.FILL, font:{fontSize:24}	
}));

var row3 = Ti.UI.createView({
	height:100, backgroundColor:'green', width:Ti.UI.FILL
});
vwContent.add(row3);

row3.add(Ti.UI.createLabel({
	color:'yellow',text:"Hola", width:Ti.UI.FILL, height:Ti.UI.FILL, font:{fontSize:24}	
}));

var goButton = Ti.UI.createButton({
	title:'Make Screenshot a PDF', bottom:10, left:10, right:10, height:80	
});
win.add(goButton);

goButton.addEventListener('click',function(e){
	Ti.Media.takeScreenshot(function(event){
		// set blob on image view
		var image = event.media;
		var pdfBlob = converters.convertImageToPDF(image,100);
		var pdfFile = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory, 'text.pdf');
		pdfFile.write(pdfBlob);	
	});
});

win.open();
