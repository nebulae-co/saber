library("dplyr")
library("readr")
library("curl")

# Get data:

ftp_auth <- readLines(con = "data-raw/ftp_auth")
server <- paste0("ftp://", ftp_auth, "@ftp.icfes.gov.co/SABER11/")

con <- curl(server, "r", new_handle(dirlistonly = TRUE))

server_files <- grep(pattern = ".zip", x = readLines(con), fixed = TRUE,
                     value = TRUE)

close(con)

files_urls <- paste0(server, server_files)

dest_files <- paste0("data-raw/raw/", server_files)
names(dest_files) <- gsub("-", "_", substr(server_files, 1, 10), fixed = TRUE)

download_if_not_exists <- function(url, destfile){
  if (!file.exists(destfile))
      curl_download(url, destfile)
  file.exists(destfile)
}

Map(download_if_not_exists, destfile = dest_files, url = files_urls)

# Read data
read_save <- function(file, ...){
  df <- list(read_delim(file, ...))
  names(df) <- names(file)

  save(list = names(df), file = file.path("data", paste0(names(df), ".rda")),
       envir = as.environment(df), compress = "xz")
}

# Get pre-specified column types
source("data-raw/column_types.R")

for (i in seq_along(dest_files)){
  file <- dest_files[i]
  read_save(file, del = "|", col_types = columns[[i]])
}
