{
dir=getDirectory("choose a directory for analysis"); 
setBatchMode(true);
write("this file path system in windows:" +dir);
dirBin=dir+"binary";
dirRoi=dir+"Roi";
dirResult=dir+"result";
 
Dialog.create("value for threshold");
Dialog.addNumber("min for threshold:", 1000);
Dialog.addNumber("max for threshold:", 65535);
Dialog.show();
min=Dialog.getNumber();
max=Dialog.getNumber();

list=getFileList(dir);
File.makeDirectory(dirBin);
count=0;
img="";

  for (i=0; i<list.length; i++) {
        if (endsWith(list[i],File.separator))
         {  
          continue;
         }
        else
           {
  //          write("the length of the files in the folder:" +list.length);	
           img=list[i];    
       write("the file is process rightnow is: "+img);
          detectGolgi(img,dir, dirBin, dirRoi, dirResult,min, max);
           }
     }
// finish reading
write("finish!!!!!");

 
     
    
}
// detect Golgi accept The dir and file tile
// And then open the image file, 
// build the save directory,
// and then save the document.
//use input img stack generate (1) binary stack,(2)ROI intermediate (3) TXT

function detectGolgi(dataTitle,dri, dirBin, dirRoi,dirResult, min, max)
{// write("all the input for detectGolgi is: "+ dataTitle+"*"+dri+"*"+ dirBin+"*"+ dirRoi+"*"+dirResult+"*"+ min+"*"+ max);
	
	dotIndex=indexOf(dataTitle,".");

if (dotIndex<0)
{ dotIndex=lengthOf(dataTitle);
}
 
imgTitle=substring(dataTitle,0,dotIndex)+"bin.tif";
         
saveImgName=dirBin+File.separator+imgTitle;
       //  write("this image after binary wil be saved:"+saveImgName);
imageToOpen=dir+dataTitle;
//write("this image to be open for process binary wil be saved:"+imageToOpen);
open(imageToOpen);
setThreshold(min,max);
nF=nSlices;
w=getWidth();
h=getHeight();

newImage(imgTitle, "8-bit black", w, h, nF);
selectWindow(dataTitle);

 
run("Analyze Particles...", "size=5-Infinity add stack");
//close(dataTitle);

count=roiManager("count");

selectWindow(imgTitle);
for (ii=0;ii<count;ii++)
{roiManager("select",ii);

run("Fill", "slice");
}
 
roiManager("reset");

selectWindow(imgTitle);
saveAs("tiff",saveImgName);
// close(saveImgName);
}
