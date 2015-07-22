require("readr")

columns <- vector("list", length(dest_files))
names(columns) <- names(dest_files)

columns$SB11_20142 <- list(PERS_FECHANACIMIENTO = col_date("%d/%m/%y"),
                           DISC_AUTISMO = col_character(),
                           DISC_SDOWN = col_character(),
                           DISC_INVIDENTE = col_character(),
                           DISC_CONDICION_ESPECIAL = col_character(),
                           DIS_MOTRIZ = col_character(),
                           DISC_SORDO = col_character(),
                           CODIGO_DANE = col_character())
