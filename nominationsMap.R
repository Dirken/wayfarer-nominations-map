#install.packages("geojsonR")
library(geojsonR)
library(leaflet)
mapaParades <- function(nameFile){
  print(nameFile$datapath)
  nominations <- FROM_GeoJson(url_file_string = nameFile$datapath)
  locations <- NULL
  city <- NULL
  day <- NULL
  description <- NULL
  imageUrl <- NULL
  order <- NULL
  state <- NULL
  status <- NULL
  title <- NULL
  upgraded <- NULL
  for(i in 1:length(nominations$features)){
    marker <- nominations$features[[i]]$geometry$coordinates
    locations <- rbind(locations, marker)
    cit <- nominations$features[[i]]$properties$city
    city <- rbind(city, cit)
    da <- nominations$features[[i]]$properties$day
    day <- rbind(day, da)
    descriptio <- nominations$features[[i]]$properties$description
    description <- rbind(description, descriptio)
    imageUr <- nominations$features[[i]]$properties$imageUrl
    imageUrl <- rbind(imageUrl, imageUr)
    orde <- nominations$features[[i]]$properties$order
    order <- rbind(order, orde)
    stat <- nominations$features[[i]]$properties$state
    state <- rbind(state, stat)
    statu <- nominations$features[[i]]$properties$status
    status <- rbind(status, statu)
    titl <- nominations$features[[i]]$properties$title
    title <- rbind(title, titl)
    upgrade <- nominations$features[[i]]$properties$upgraded
    upgraded <- rbind(upgraded, upgrade)
  }
  
  locations <- as.data.frame(locations)
  colnames(locations) <- c("lat", "lng")
  city <- as.data.frame(city)
  colnames(city) <- "city"
  day <- as.data.frame(day)
  colnames(day) <- "day"
  description <- as.data.frame(description)
  colnames(description) <- "description"
  imageUrl <- as.data.frame(imageUrl)
  colnames(imageUrl) <- "imageUrl"
  order <- as.data.frame(order)
  colnames(order) <- "order"
  state <- as.data.frame(state)
  colnames(state) <- "state"
  status <- as.data.frame(status)
  colnames(status) <- "status"
  title <- as.data.frame(title)
  colnames(title) <- "title"
  upgrade <- as.data.frame(upgrade)
  colnames(upgraded) <- "upgraded"
  
  result <- as.data.frame(list(location = locations, 
                      city = city,
                      day = day,
                      description = description,
                      image = imageUrl,
                      number = order,
                      state = state,
                      status = status,
                      title = title,
                      upgraded = upgraded))
  
  icons <- awesomeIconList(green = makeAwesomeIcon(icon = 'flag', markerColor = 'green', library='fa', iconColor = 'black'),
                    red = makeAwesomeIcon(icon = 'flag', markerColor = 'red', library='fa', iconColor = 'black'),
                    orange = makeAwesomeIcon(icon = 'flag', markerColor = 'orange', library='fa', iconColor = 'black'),
                    grey = makeAwesomeIcon(icon = 'flag', markerColor = 'grey', library='fa', iconColor = 'black'),
                    blue =  makeAwesomeIcon(icon = 'flag', markerColor = 'blue', library='fa', iconColor = 'black'),
                    black = makeAwesomeIcon(icon = 'flag', markerColor = 'black', library='fa', iconColor = 'black')
  )
  beatCol <- colorFactor(palette = c('green', 'blue', 'black','red', 'orange', 'grey'),
                         domain = result$status)
  leaflet(result) %>% addTiles() %>% addCircleMarkers(
    lng = result$location.lat, lat = result$location.lng,
    label = as.character(result$title),
    color = ~beatCol(status),
    fillOpacity = 0.8,
    stroke = T
  ) %>%
    addLegend('bottomright', pal = beatCol, values = result$status,
              title = 'Legend',
              opacity = 1)
}