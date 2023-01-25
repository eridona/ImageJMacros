//this macro is to mask IS2 registered images and temporal color project them

run("Close All");

dir1 = getDirectory("Choose Source Directory");
outdir = getDirectory("Choose Destination Directory");
maskdir = getDirectory("Choose Mask Dir");
list = getFileList(dir1);

setBatchMode(true);
for (i=0; i<list.length; i++)
        {
        	path = dir1+list[i];
        	run("Bio-Formats Importer", "open=" + path);
        	image = getImageID();
        	selectImage(image);
        	title = File.nameWithoutExtension;
        	open(maskdir+"IS2NeuropilThresholdClosed_generous.nrrd");
			mask = getImageID();
        	imageCalculator("Multiply create stack", image,mask);
        	masked = getImageID();
        	selectImage(masked);
        	setMinAndMax(0, 50000);
        	run("Temporal-Color Code", "lut=PsychedelicRainBow2 start=1 end=173");
        	selectImage("MAX_colored");
        	saveAs("Tiff", outdir+"colorproj_"+title+".tif");
        	run("Close All");
        	run("Collect Garbage");
        }

setBatchMode(false);