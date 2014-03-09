/**
 * benCoding.PDF Titanium Project
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 *
 */
package bencoding.pdf;

import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;

import org.appcelerator.titanium.TiApplication;

@Kroll.module(name="Pdf", id="bencoding.pdf")
public class PdfModule extends KrollModule
{

	// Standard Debugging variables
	public static final String MODULE_FULL_NAME = "becoding.pdf";
	
	public PdfModule()
	{
		super();
	}

	@Kroll.onAppCreate
	public static void onAppCreate(TiApplication app)
	{
		//Log.d(LCAT, "inside onAppCreate");
		// put module init code that needs to run when the application is created
	}

}

