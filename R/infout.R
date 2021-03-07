#' Funcion para obtener la cantidad, valor maximo y minimo de datos dudosos.
#'
#' @param data conjunto de datos (dataframe) de series mensuales.
#' @param estaciones conjunto de datos (dataframe) de las estaciones.
#' @importFrom graphics plot
#' @importFrom grDevices dev.off
#' @export
#' @name infout
#'

infout <- function( data, estaciones){
  if(is.data.frame(data)) {
    data = data
  } else {
    stop("los datos de las series de tiempo no son adecuados")
  }

  if(is.data.frame(estaciones)){
    estaciones = estaciones
  } else {
    stop("los datos de las estaciones no son adecuados")
  }

  colnames(data)[1] <- "Fecha"
  colnames(estaciones)[1] <- "Estacion"
  info.outliers <- data.frame(Estacion = estaciones$Estacion,
                              cantidad.out = NA, min.out = NA, max.out = NA)
  bp.data <- data.frame( data, meses = months(data$Fecha,3))
  meses <- factor(bp.data$meses, levels = unique(months(bp.data$Fecha,3)))
  for (i in 1:(ncol(data)-1)) {
    bp <- plot(x = meses, y = data[,i+1])
    dev.off()
    info.outliers$cantidad.out[i] <- sum(!is.na(bp$out))
    info.outliers$min.out[i] <- min(bp$out)
    info.outliers$max.out[i] <- max(bp$out)
  }
  return(info.outliers)
}

