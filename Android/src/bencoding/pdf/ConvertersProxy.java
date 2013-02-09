/**
 * benCoding.PDF Titanium Project
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 *
 */
package bencoding.pdf;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;

import org.appcelerator.kroll.KrollProxy;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.kroll.common.Log;
import org.appcelerator.titanium.TiBlob;
import org.appcelerator.titanium.view.TiDrawableReference;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.PdfWriter;
import android.graphics.Bitmap;

@Kroll.proxy(creatableInModule=PdfModule.class)
public class ConvertersProxy extends KrollProxy {

	private static final String LCAT = "PdfModule";
	
	public ConvertersProxy()
	{
		super();		
	}
	
	// Methods
	@Kroll.method
	public TiBlob convertImageToPDF(TiBlob blob, @Kroll.argument(optional=true) Object resolution) throws Exception
	{
		TiBlob result = null;
		Bitmap bitmap = null;
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		TiDrawableReference ref = TiDrawableReference.fromBlob(getActivity(), blob);
		Document document=new Document();
	        try {
				PdfWriter.getInstance(document,outputStream);
		        document.open();
		        bitmap  = ref.getBitmap();
		        ByteArrayOutputStream stream = new ByteArrayOutputStream();
		        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
		        byte[] bitmapdata = stream.toByteArray();		        
		        Image image1 = Image.getInstance(bitmapdata);
		        document.add(image1);
		        document.close();
		        byte[] bytes = outputStream.toByteArray();
		        result = TiBlob.blobFromData(bytes);
		        return result;
		        
			} catch (FileNotFoundException e) {
				e.printStackTrace();
				Log.i(LCAT, e.toString());
			} catch (DocumentException e) {
				Log.i(LCAT, e.toString());
				e.printStackTrace();
			}
		finally {
			if (bitmap != null) {
				bitmap.recycle();
				bitmap = null;
			}
			outputStream = null;
			ref = null;
			document = null;
		}

		return result;
	}
}
