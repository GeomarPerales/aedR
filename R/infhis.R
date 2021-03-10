#' Funcion para obtener un resumen del histograma de datos mensuales para AED.
#'
#' @param data conjunto de datos (dataframe) de series mensuales.
#' @param estaciones conjunto de datos (dataframe) de las estaciones.
#' @export
#' @name infhis
#'

infhis <- function( data, estaciones){
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
  est.data <- data.frame(Estacion = estaciones$Estacion, Max = NA, P1Q = NA,
                         Fmax = NA, P3Q = NA, Min = NA)
  h <- hist(data[,i], plot = FALSE)
  h$density <- h$counts/sum(h$counts)*100

  for (i in 1:(ncol(data)-1)){
    smr <-summary(data[,i+1])
    rest.data$Max[i] <- as.numeric(smr[1])
    rest.data$P1Q[i] <- as.numeric(smr[2])
    rest.data$Fmax[i] <- as.character(data$Fecha[which.max(data[,i+1])])
    rest.data$P3Q[i] <- as.numeric(smr[4])
    rest.data$Min[i] <- as.numeric(smr[5])
  }
  return(infhis)
}
