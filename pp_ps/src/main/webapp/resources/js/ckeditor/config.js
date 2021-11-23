/**
 * @license Copyright (c) 2003-2021, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here.
	// For complete reference see:
	// https://ckeditor.com/docs/ckeditor4/latest/api/CKEDITOR_config.html

	// The toolbar groups arrangement, optimized for two toolbar rows.
	config.resize_enaleb = false;
	config.enterMode = CKEDITOR.ENTER_BR;
	config.shiftEnterMode = CKEDITOR.ENTER_P;
	config.filebrowserUploadUrl = "/admin/upload/ckEditor";
	config.language= 'ko';
	config.uiColor= '#45d4d4';
	config.extraPlugins= 'image2,editorplaceholder';
	config.editorplaceholder= '내용을 입력해주세요2';
	config.toolbarGroups = [
								{ name: 'clipboard', groups: [ 'undo', 'clipboard' ] },
								{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
								{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
								{ name: 'insert', groups: [ 'insert' ] },
								{ name: 'colors', groups: [ 'colors' ] },
								'/',
								{ name: 'styles', groups: [ 'styles' ] },
								{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
								{ name: 'editing', groups: [ 'selection', 'find', 'spellchecker', 'editing' ] },
								{ name: 'forms', groups: [ 'forms' ] },
								{ name: 'links', groups: [ 'links' ] },
								{ name: 'tools', groups: [ 'tools' ] },
								{ name: 'others', groups: [ 'others' ] },
								{ name: 'about', groups: [ 'about' ] }
	];

	// Remove some buttons provided by the standard plugins, which are
	// not needed in the Standard(s) toolbar.
	config.removeButtons = 'Save,ExportPdf,Preview,Print,NewPage,Templates,Cut,Copy,Paste,PasteText,PasteFromWord,Find,Replace,Scayt,CopyFormatting,RemoveFormat,CreateDiv,Language,BidiRtl,BidiLtr,Link,PageBreak,Iframe,Anchor,Unlink,About,ShowBlocks,Maximize,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,SelectAll,Subscript,Superscript,Blockquote'
						  

	// Set the most common block elements.
	config.format_tags = 'p;h1;h2;h3;pre';

	// Simplify the dialog windows.
	config.removeDialogTabs = 'image:advanced;link:advanced';
};
