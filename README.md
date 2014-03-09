
benCoding.PDF.Converters

The benCoding.PDF Converters proxy provides conversion helper functions when working with PDFs.  At the moment the feature list is pretty small, but will be growing as needed or contributions are provided. 

<h2>Before you start</h2>
* This is a module designed to work with Titanium SDK 3.0.0GA
* Before using this module you first need to install the package. If you need instructions on how to install a 3rd party module please read this installation guide.

<h2>Download the release</h2>

There is two ways you can download this module. 

Android:

The go to the [dist](https://github.com/benbahrenburg/benCoding.PDF/tree/master/Android/dist) folder. This will have a release compiled for anyone download it from github.

iOS: 

The go to the [dist](https://github.com/benbahrenburg/benCoding.PDF/tree/master/iOS/dist) folder. This will have a release compiled for anyone download it from github.


<h2>Building from source?</h2>

If you are building from source you will need to do the following:
* Modify the titanium.xcconfig file with the path to your Titanium installation

<h2>Setup</h2>

* Download the latest release from the releases folder ( or you can build it yourself )
* Install the bencoding.sms module. If you need help here is a "How To" [guide](https://wiki.appcelerator.org/display/guides/Configuring+Apps+to+Use+Modules). 
* You can now use the module via the commonJS require method, example shown below.

<pre><code>
var pdf = require('bencoding.pdf');
</code></pre>

<h2>Creating the Converters Object</h2>

Requiring the module into your project

<pre><code>
//Require the securely module into your project
var pdf = require('bencoding.pdf');
//Create a new properties object
var converters = pdf.createConverters();
</code></pre>

<h2>Methods</h2>

<b>convertImageToPDF</b>( TiBlob image, int resolution )
Adds the specified callback as an event listener for the named event.

<b>Parameters</b>
image : TiBlob
Image to be converted into PDF
resolution : int
Optional resolution value. Only applies to iOS

<b>Returns</b>
TiBlob

<b>Example</b>
<pre><code>
	Ti.Media.takeScreenshot(function(event){
		// set blob on image view
		var image = event.media;
		var pdfBlob = converters.convertImageToPDF(image,100);
		var pdfFile = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory, 'text.pdf');
		pdfFile.write(pdfBlob);	
	});
</code></pre>

----


<h2>Dependent Projects</h2>
The benCoding.PDF module uses the below projects.  I highly encourage you to check them out using the information below.

iText ( used on Android only) 

Please visit [iText Website](http://itextpdf.com) to learn more

Please note iText is licensed under the GNU Affero General Public License version 3 and depending on the nature of your app you might need a license. Please visit [license](http://itextpdf.com/terms-of-use/index.php) for details.


<h2>Licensing & Support</h2>

This project is licensed under the OSI approved Apache Public License (version 2). For details please see the license associated with each project.

Developed by [Ben Bahrenburg](http://bahrenburgs.com) available on twitter [@benCoding](http://twitter.com/benCoding)

<h2>Learn More</h2>

<h3>Examples</h3>
Please check the module's example folder for details. 

These samples are also available on github at the following:

[Android Examples](https://github.com/benbahrenburg/benCoding.PDF/tree/master/Android/example) 

[iOS Examples](https://github.com/benbahrenburg/benCoding.PDF/tree/master/iOS/example) 


<h3>Twitter</h3>

Please consider following the [@benCoding Twitter](http://www.twitter.com/benCoding) for updates 
and more about Titanium.

<h3>Blog</h3>

For module updates, Titanium tutorials and more please check out my blog at [benCoding.Com](http://benCoding.com).