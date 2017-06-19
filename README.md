# nde-licensed-personnel
Process and analyze the Directory of Licensed Personnel pdfs from the [Nevada Department of Education website](http://www.doe.nv.gov/Resources/Directory_Licensed_Personnel/).

  - [2015-2016 Licensed Personnel Direcory](http://www.doe.nv.gov/uploadedFiles/ndedoenvgov/content/Resources/Directory_of_Licensed_Personnel/Directory_Licensed_Personnel_1516.pdf)
  - [2014-2015 Licensed Personnel Direcory](http://www.doe.nv.gov/uploadedFiles/ndedoenvgov/content/Resources/Directory_of_Licensed_Personnel/Directory_Licensed_Personnel_1415.pdf)
  
### Issue Processing PDF
I used `pdftools` to process the pdf files as best I could, but still ended up with hundreds of errors in creating the data frames that I needed to fix manually.  If you have any suggestions on how to imporve this the code I used is in `R/process_nde_license.R`

