/**
 * @license Copyright (c) 2003-2019, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
    config.fullPage = true;
    config.allowedContent = true;
    config.extraPlugins = 'docprops,language,menubutton,button,menu,font,richcombo,floatpanel,panel,spacingsliders,lineheight';

   // config.extraAllowedContent = "*(*)[onclick]";//Cho phép onclick
    config.extraAllowedContent = '*(*);*{*}';
    config.language = 'vi';

};
