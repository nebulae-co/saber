library("dplyr")
library("readr")
library("curl")

# Get data:

ftp_auth <- readLines(con = file.path("data-raw", "ftp_auth"))
server <- paste0("ftp://", ftp_auth, "@ftp.icfes.gov.co/SABER11/")

con <- curl(server, "r", new_handle(dirlistonly = TRUE))

files <- grep(pattern = ".zip", x = readLines(con), fixed = TRUE, value = TRUE)
file_name <- function(file){gsub("-", "_", substr(file, 1, 10), fixed = TRUE)}

close(con)

download_if_not_exists <- function(url, destfile){
  if (!file.exists(destfile))
      curl_download(url, destfile)
  file.exists(destfile)
}

Map(download_if_not_exists, destfile = file.path("data-raw", "raw", files),
    url = paste0(server, files))

# Read data

## Read or make file with column types
get_types <- function(file, ...){
  types_file <- file.path("data-raw", "types", paste0(file_name(file), ".csv"))

  if (!file.exists(file.path(types_file))){
    df <- read_delim(file.path("data-raw", "raw", file), del = "|",
                     na = c("---", "-1", "", "            "), n_max = 100)

    types_df <- data_frame(Variable = names(df), Tipo = sapply(df, typeof)) %>%
      mutate(Tipo = ifelse(Tipo == "double", paste0("col_euro_", Tipo, "()"),
                           paste0("col_", Tipo, "()")))

    write_csv(types_df, types_file)
    lapply(parse(text = types_df[["Tipo"]]), eval)
  } else {
    types_df <- read_csv(types_file)
    lapply(parse(text = types_df[["Tipo"]]), eval)
  }
}

columns <- lapply(files, get_types)

read_save <- function(file, ...){
  df <- list(read_delim(file, ...))
  names(df) <- file_name(file)

  save(list = names(df), file = file.path("data", paste0(names(df), ".rda")),
       envir = as.environment(df), compress = "xz")
}

Map(read_save, file = files, del = "|", col_types = columns,
    na = c("---", "-1", "", "            "))
