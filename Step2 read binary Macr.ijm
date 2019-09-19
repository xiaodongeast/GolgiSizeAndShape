setBatchMode(true);
dir=getDirectory("choose a directory for analysis"); 
list2=getFileList(dir);
dirResult=dir+"result";
File.makeDirectory(dirResult);

count2=0;
img2="";

  for (i=0; i<list2.length; i++) {
        if (endsWith(list2[i], File.separator))
          {
          	continue;
          }
        else
           {img2=list2[i];    
           write(img2);
           // opnen call detection 
               dotIndex=indexOf(img2,".");

              if (dotIndex<0)
               { dotIndex=lengthOf(img2);
               }
               TextTitle=substring(img2,0,dotIndex)+".txt";
               saveTextName=dirResult+File.separator+TextTitle;
               write("the text to save " +saveTextName);
               imageToOpen=dir+img2;
                 write("the image to open " +saveTextName);
           open(imageToOpen);
           w1=getWidth();
           h1=getHeight();
           totalP=0;
          run("Clear Results");
          for (j=1;j<=nSlices;j++)
              {setSlice(j);
              for (mj=0; mj<w1; mj++)
                   {for (nj=0; nj<h1;  nj++)
                       { //write ("mj"+mj);
                          inten=getPixel(mj,nj);
                          // write("inten" + inten);
                            if (inten>100)
                               {setResult("X",totalP,mj);
                                setResult("Y",totalP,nj);   // change to the array
                                setResult("Z",totalP,j);
                                 totalP++;
                                }
       // write("j" +j);
       // write("totalP"+totalP);
                       }
                   }    
           updateResults();
             }
           selectWindow("Results");
          saveAs("txt",saveTextName);  
         //  close(saveTextName);
           close(img2);
           
           }
      }