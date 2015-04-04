title <- function(...) stri_trans_totitle(...)

price_format <- function(x){
  paste("$", prettyNum(x, big.mark = "."))
}

get_data_sample <- function(){
  library("arules")
  data(Groceries)
  set.seed(1313)
  data <- Groceries@itemInfo %>%
    mutate(id = sample(nrow(.)),
           name = as.character(labels) %>% title,
           category = as.character(level1) %>% title,
           description = as.character(level2)  %>% title,
           details = text_sample(),
           price = round(runif(nrow(.))*100)*100) %>%
    select(id, name, category, price, description, details) %>%
    tbl_df   
    
}

text_sample <- function(){
  "Bitters Helvetica whatever tousled, fanny pack roof party master cleanse paleo freegan iPhone sriracha. Williamsburg forage freegan narwhal leggings trust fund. Meditation freegan tote bag viral. Farm-to-table keytar biodiesel Schlitz paleo readymade, roof party retro lo-fi mumblecore Intelligentsia Banksy"
}

get_data <- function(){
  key <- KEY_GSS
  ss <- register_ss(key)
  data <- ss %>%  get_via_csv() 
  data
}

product_template_grid <- function(x){
  
  # x <- sample_n(data, 1)
  
  column(3, class="prodbox", id = sprintf("prod_%s", x$id),
         div(class="prodboxinner",
             img(class="imgthumb img-responsive center-block",
                 src=sprintf("http://lorempixel.com/200/200/food/1/%s/", x$name))
             ),
         div(class="prodboxinner",
             h5(x$name)
             ),
         a(href="",
           div(class="panel-footer prodboxinner",
               span(class="pull-left", price_format(x$price)),
               span(class="pull-right", tags$i(class="fa fa-arrow-circle-right")),
               div(class="clearfix")
              )
           )
         )
}

product_template_list <- function(x){
  
  # x <- sample_n(data, 1)
  
  column(12, class="prodbox", id = sprintf("prod_%s", x$id),
         fluidRow(
            column(4,
                   img(class="imgthumb img-responsive center-block",
                       src=sprintf("http://lorempixel.com/200/200/food/1/%s/", x$name))
                   ),
            column(4,
                   h5(x$name)
                   ),
            column(4,
                   price_format(x$price)
                   )
           )
         )
         
       
}

product_detail_template <- function(x){
  
  # x <- sample_n(data, 1)
  
  div(class="row-fluid",
      column(4,
             div(class="row-fluid",
                 column(6, img(class="imgthumb img-responsive", src=sprintf("http://lorempixel.com/200/200/food/1/%s/", x$name))),
                 column(6, img(class="imgthumb img-responsive", src=sprintf("http://lorempixel.com/200/200/food/1/%s/", x$name))),
                 column(6, img(class="imgthumb img-responsive", src=sprintf("http://lorempixel.com/200/200/food/1/%s/", x$name))),
                 column(6, img(class="imgthumb img-responsive", src=sprintf("http://lorempixel.com/200/200/food/1/%s/", x$name))),
                 column(6, img(class="imgthumb img-responsive", src=sprintf("http://lorempixel.com/200/200/food/1/%s/", x$name))),
                 column(6, img(class="imgthumb img-responsive", src=sprintf("http://lorempixel.com/200/200/food/1/%s/", x$name)))
                 )
             ),
      column(8,
             h3(x$name),
             tags$dl(
                     tags$dt("Desciption"), tags$dd(x$description),
                     tags$dt("Details"), tags$dd(x$details),
                     tags$dt("Stock"), tags$dd(5)
                     ),
             hr(),
             div(class="row-fluid",
                 column(6,
                        tags$button(class="btn btn-success", price_format(x$price))
                        ),
                 column(6,
                        actionButton("addtocart", class="pull-right btn-success",
                                     tags$i(class="fa fa-cart-plus"), "Add to cart ")
                        )
                 )
             )
      )
}