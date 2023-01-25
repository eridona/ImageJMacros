dir1 = getDirectory("Choose Source Directory");
list = getFileList(dir1);
parent = File.getParent(dir1);
parent = parent + "/" 
dir2 = parent+"greenMAX"+File.separator;
dir3 = parent+"redMAX"+File.separator;
dir4 = parent+"farredMAX"+File.separator;

File.makeDirectory(dir2);
File.makeDirectory(dir3);
setBatchMode(true);

for (i=0; i<list.length; i++)
        {
       
        if (File.isDirectory(dir1+list[i])){}
        else{
        	 path = dir1+list[i];
        	 run("Bio-Formats Importer", "open=" + path);//Opens the stack
        	 run("Rotate... ", "angle=-50 grid=1 interpolation=Bilinear enlarge stack");
        	 
                		title = File.nameWithoutExtension ;               
                        getDimensions(width, height, channels, slices, frames);
                        if (channels == 2) {
                        	name=getTitle();
                        	run("Split Channels");
            				selectWindow("C2-"+name);
                       		zMax = nSlices;
                        	run("Z Project...", "start=1 stop=zMax projection=[Max Intensity] all");
                        	saveAs("Tiff", dir2+title+"C2max.tif");
                              
                        	selectWindow("C1-"+name);
		        			run("Z Project...", "start=1 stop=zMax projection=[Max Intensity] all");
		        			saveAs("Tiff", dir3+title+"C1max.tif");
							run("Close All");
							} else if (channels == 3) {
							File.makeDirectory(dir4);
							name=getTitle();
                        	run("Split Channels");
            				selectWindow("C2-"+name);
                       		zMax = nSlices;
                        	run("Z Project...", "start=1 stop=zMax projection=[Max Intensity] all");
                        	saveAs("Tiff", dir2+title+"C2max.tif");
                              
                        	selectWindow("C1-"+name);
		        			run("Z Project...", "start=1 stop=zMax projection=[Max Intensity] all");
		        			saveAs("Tiff", dir3+title+"C1max.tif");

		        			selectWindow("C3-"+name);
		        			run("Z Project...", "start=1 stop=zMax projection=[Max Intensity] all");
		        			saveAs("Tiff", dir4+title+"C3max.tif");
							run("Close All");
							}
						else {
							zMax = nSlices;
                        	run("Z Project...", "start=1 stop=zMax projection=[Max Intensity] all");
                        	saveAs("Tiff", dir2+title+"C1max.tif");
                        	run("Close All");
						}
        }                 	
        }
                       