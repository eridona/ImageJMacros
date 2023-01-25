dir1 = getDirectory("Choose Source Directory");
list = getFileList(dir1);
parent = File.getParent(dir1);
parent = parent + "/" 
dir2 = parent+"greenMAX"+File.separator;

File.makeDirectory(dir2);
setBatchMode(true);

for (i=0; i<list.length; i++)
        {
       
        if (File.isDirectory(dir1+list[i])){}
        else{
        	 path = dir1+list[i];
        	 run("Bio-Formats Importer", "open=" + path);//Opens the stack
        	 
                		title = File.nameWithoutExtension ;               
                        getDimensions(width, height, channels, slices, frames);
							zMax = nSlices;
                        	run("Z Project...", "start=1 stop=zMax projection=[Max Intensity] all");
                        	saveAs("Tiff", dir2+title+"C1max.tif");
                        	run("Close All");
        }                 	
        }
                       