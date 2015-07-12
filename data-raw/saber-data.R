library("dplyr")
library("readr")
library("RCurl")
library("curl")

# Get data:

ftp_auth <- readLines(con = "data-raw/ftp_auth")
server <- paste0("ftp://", ftp_auth, "@ftp.icfes.gov.co/SABER11/")

server_files <- strsplit(getURL(server, dirlistonly = TRUE), "\n")[[1]] %>%
  grep(pattern = ".zip", x = ., fixed = TRUE, value = TRUE)

for (i in seq_along(server_files)){
  file <- paste0(server, server_files[i])
  dest <- paste0("data-raw/", server_files[i])
  if(!file.exists(dest)) curl_download(url = file, destfile = dest)
}


columns <- list(
  PERS_FECHANACIMIENTO = col_date("%d/%m/%y"),
  DISC_AUTISMO = col_character(),
  DISC_SDOWN = col_character(),
  DISC_INVIDENTE = col_character(),
  DISC_CONDICION_ESPECIAL = col_character(),
  DIS_MOTRIZ = col_character(),
  DISC_SORDO = col_character(),
  CODIGO_DANE = col_character()
  )

saber <- read_delim(file = disk_file, del = "|", col_types = columns, n_max = 50)

saber <- read_delim(file = file, del = "|", col_types = columns, n_max = 50)

#            proquote = '\"', escape_backslash = TRUE,
#            escape_double = FALSE, na = "NA", col_names = TRUE,
#            col_types = NULL, skip = 0, n_max = -1,
#            progress = interactive())
# unzip(zipfile = "data-raw/SB11-20142-RGSTRO-CLFCCN-V1-0.zip",
#       exdir = "data-raw/")
