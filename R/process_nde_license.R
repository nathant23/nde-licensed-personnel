library(pdftools)
library(stringr)
library(dplyr)

process_nde_license <- function(file_name, page_start, page_end){
  
  data_set <- pdf_text(file_name)
  
  df <- data.frame(School.District = character(),
                   School.Name     = character(),
                   Last.Name       = character(),
                   First.Name      = character(),
                   License.Number  = integer(),
                   stringsAsFactors = FALSE)
  
  for (n in page_start:page_end) {
    # Seperate the text into individual lines to be processed.
    page <- strsplit(data_set[n], "\r\n")
    
    # Loop through lines to find line that will give accurate column widths.
    for (line in page[[1]]) {
      # Find a CLARK line that has three columns of data preceeded by two spaces.
      if (substr(line, 1,5) == 'CLARK' & length(str_locate_all(line, '  [A-Z]')[[1]]) == 6) {
        meta <- str_locate_all(line, '  [A-Z]')[[1]]
        col1_end   <- meta[1,1] - 1
        col2_start <- meta[1,1]
        col2_end   <- meta[2,1] - 1
        col3_start <- meta[2,1]
        col3_end   <- meta[3,1] - 1
        col4_start <- meta[3,1]
        col4_end   <- str_locate(line, '[0-9]')[1,1] - 1
        col5_start <- str_locate(line, '[0-9]')[1,1]
        break
      }
    }
    ## Append Clark data to the data frame.
    for (line in page[[1]]) {
      
      if (substr(line, 1,5) == 'CLARK') {
        df <- rbind.data.frame(df, c(trimws(substr(line, 1, col1_end)),
                                     trimws(substr(line, col2_start, col2_end)),
                                     trimws(substr(line, col3_start, col3_end)),
                                     trimws(substr(line, col4_start, col4_end)),
                                     trimws(substr(line, col5_start, nchar(line)))),
                               stringsAsFactors = FALSE)
      }
    }
  }
  
  names(df) <- c('School.District', 'School.Name', 'Last.Name', 'First.Name', 'License.Number')
  
  return(df)
}

