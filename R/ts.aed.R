#' Funcion para obtener la Serie de tiempo mensual para AED.
#'
#' @param data conjunto de datos (dataframe) de series mensuales.
#' @param estaciones conjunto de datos (dataframe) de las estaciones.
#' @param i N° de orden (integer) de la estación
#' @param col color de los datos dudosos (outliers). --
#' @param variable nombre de la variable hidrológica.
#' @param um unidad de medida. ejm.: mm (Precipitación).
#' @importFrom stats plot.ts
#' @importFrom stats ts
#' @export
#' @name ts.aed
#'

ts.aed <- function( data, estaciones, i = NULL, col = NULL, variable = NULL, um = NULL){
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

  if(is.numeric(i) & !is.null(i)){
    i = i
  } else if(is.null(i)) {
    i = 2
  } else {
    stop("Numero de orden de estacion no definido")
  }

  if(is.null(col)){
    col = "navy"
  } else if(is.character(col)){
    col = col
  } else {
    stop("Numero de orden de estacion no definido")
  }

  if(is.null(variable)){
    variable = "Precipitacion"
  } else if(is.character(variable)){
    variable = variable
  } else {
    stop("variable no definida")
  }

  if(is.null(um)){
    um = "mm"
  } else if(is.character(um)){
    um = um
  } else {
    stop("unidad de medida no definida")
  }
  colnames(data)[1] <- "Fecha"
  colnames(estaciones)[1] <- "Estacion"
  ts.data <- as.vector(data[,i])
  year <- as.numeric(substr(data$Fecha[1],1,4))
  mes <- abs(as.numeric(substr(data$Fecha[1],5,7)))
  ts.data <- ts(ts.data, frequency = 12, start = c( year, mes))
  plot.ts( ts.data, xlab = "Tiempo (meses)", lwd = 2, col = col,
          ylab = paste0( variable, " [",um,"/mes]"), main = estaciones$Estacion[i-1])
}


