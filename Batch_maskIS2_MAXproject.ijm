//this macro is to mask and project IS2 registered images
run("Close All");

dir1 = getDirectory("Choose Source Directory");
outdir = getDirectory("Choose Destination Directory");
list = getFileList(dir1);

setBatchMode(true);
for (i=0; i<list.length; i++)
        {
        	path = dir1+list[i];
        	run("Bio-Formats Importer", "open=" + path);
        	image = getImageID();
        	selectImage(image);
        	title = File.nameWithoutExtension;
        	open("/Users/erikadona/Documents/Projects/Neuroanatomy/Mask_neuropil_only/IS2NeuropilThresholdClosed_generous.nrrd");
			mask = getImageID();
        	imageCalculator("Multiply create stack", image,mask);
        	masked = getImageID();
        	selectImage(masked);
        	run("Z Project...", "projection=[Max Intensity]");
        	saveAs("Tiff", outdir+"MAX_masked_"+title+".tif");
        	run("Close All");
        	run("Collect Garbage");
        }

setBatchMode(false);