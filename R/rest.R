#' Funcion para obtener un resumen estadistico de un conjunto de series de tiempo.
#'
#' @param data conjunto de datos (dataframe) de series mensuales.
#' @param estaciones conjunto de datos (dataframe) de las estaciones.
#' @export
#' @name rest
#'

rest <- function( data, estaciones){
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
  rest.data <- data.frame(Estacion = estaciones$Estacion,
                          Max = NA, P1Q = NA, Fmax = NA, P3Q = NA, Min = NA)
  for (i in 1:(ncol(data)-1)){
    smr <-summary(data[,i+1])
    rest.data$Max[i] <- as.numeric(smr[1])
    rest.data$P1Q[i] <- as.numeric(smr[2])
    rest.data$Fmax[i] <- as.character(data$Fecha[which.max(data[,i+1])])
    rest.data$P3Q[i] <- as.numeric(smr[4])
    rest.data$Min[i] <- as.numeric(smr[5])
  }
  return(rest.data)
}
