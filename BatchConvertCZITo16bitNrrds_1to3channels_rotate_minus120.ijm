requires("1.33s"); 
//showMessage ("You need to have your source Images all in one Folder (source) within a parental folder. A destination folder with the nrrd files will be created in the parental folder")
//showMessage ("This assumes that 
	//if there is only 1 channel, this is the neuropil stain 
	//if there are more than 1 channels your neuropil stain is channel 1
//Written by Erika
run("Close All");
dir = getDirectory("Choose a directory with .czi images");
//showMessage(dir);
parent = File.getParent(dir);
parent = parent + "/" 
//showMessage(parent);
dir1 = parent + "nrrds"+File.separator; 
 
File.makeDirectory(dir1);
setBatchMode(true);

list = getFileList(dir);

		for (i=0; i<list.length; i++) 
		{

		path = dir+list[i];
		run("Bio-Formats Importer", "open=" + path);//Opens the stack
		title=File.nameWithoutExtension;
		//print(noext);
		getDimensions(width, height, channels, slices, frames);
		run("Rotate... ", "angle=-120 grid=1 interpolation=Bilinear enlarge stack");
		
		if (channels==1) {
			print(title);
			print("number of channels ="+channels);
			setKeyDown("alt"); //allows saving as compression nrrd
			run("Nrrd ... ", "nrrd=["+dir1+title+"_01"+".nrrd]");
			}
			
			else {
			name=getTitle();
			run("Split Channels");
			print(title);
			print("number of channels ="+channels);
			for (j=0; j<channels; j++) 
			{
				if(j==0) channel="_01";
				if(j==1) channel="_02";
				if(j==2) channel="_03";
			//showMessage(channel+" check-1");
			//print("C"+(j+1)+"-"+name);
			selectImage("C"+(j+1)+"-"+name);
			//showMessage(channel+" check-2");
			setKeyDown("alt"); //allows saving as compression nrrd
			run("Nrrd ... ", "nrrd=["+dir1+title+channel+".nrrd]");
			close();
			}
			}
	
}
print("finished");