The purpose of this directory is to verify the transformation between CDA and GreenCDA
Prerequisites are
	Java SDK
	Gradle

Once this is installed one can run the following from the commandline

	$ gradle test

This will run through the steps explained below.

	1.	Take the .xml files from ../schemas/interactions/GetCareDocumentationInteraction/hl7cda/samples and apply the ../schemas/interactions/GetCareDocumentationInteraction/hl7cda/transformations/CDA_to_GreenCDA.xslt
		and write the result of the transformation to ./test/GreenCDA/

	2.	Take the .xml files from ./test/GreenCDA/ and apply the ./schemas/interactions/GetCareDocumentationInteraction/hl7cda/transformations/GreenCDA_to_CDA.xslt
		and write the result of the transformation to ./test/CDA/

	3.	Run XMLDiff on all .xml files in ./test/CDA/ and compare them to the original .xml files in ../schemas/interactions/GetCareDocumentationInteraction/hl7cda/samples

	4.	Run xml schema validation on all .xml files in ./test/GreenCDA

	5.	Run xml schema validation on all .xml files in ./test/CDA
