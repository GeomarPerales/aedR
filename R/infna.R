#' funcion para obtener la Informacion no disponible (NA's) de un conjunto de
#' series de tiempo.
#'
#' @param data conjunto de datos (dataframe) de series mensuales.
#' @param estaciones conjunto de datos (dataframe) de las estaciones.
#' @importFrom formattable percent
#' @export
#' @name infna
#'

infna <- function( data, estaciones){
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
  infna <- data.frame(Estacion = estaciones$Estacion,
                      Cantidad = NA, Porcentaje = NA)
  for (j in 1:nrow(estaciones)) {
    for (i in 1:(ncol(data)-1)) {
      infna$Cantidad[i] <- sum(is.na(data[,i+1]))
      infna$Porcentaje[i] <- sum(is.na(data[,i+1]))/nrow(data)
    }
  }
  infna$Porcentaje <- formattable::percent(infna$Porcentaje)
  return(infna)
}
