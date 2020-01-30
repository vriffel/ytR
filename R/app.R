library(shiny)

ui <- fluidPage(
    titlePanel("YouTubeR"),
    mainPanel(
        tabsetPanel(
            tabPanel("DL",
                     textInput("URL", "Type the URL:", ""),
                     checkboxGroupInput(
                         inputId = "OPTIONS", label = "Choose the options",
                         choiceNames = c("Download just audio.", "Change name."),
                         choiceValues = c("-x", "-o")),
                     conditionalPanel(
                         "input.OPTIONS.includes('-x')",
                         checkboxGroupInput(
                             "AUDIOFORMAT", label = "Select audio format.",
                             choiceNames = c("mp3"),
                             choiceValues = c("--audio-format mp3"))),
                     conditionalPanel(
                         "input.OPTIONS.includes('-o')",
                         textInput(
                             "NAME", label = "Type the name.")
                     ),
                     actionButton("DOWNLOAD", label = "Download"),
                     verbatimTextOutput("value")),
            tabPanel("ED")
        ) ## tabsetPanel
    ) ## mainPanel
) ## fluidPage

server <- function(input, output) {
    observeEvent(input$DOWNLOAD, {
        options2 <- c(input$AUDIOFORMAT)
        url <- input$URL
        options <- input$OPTIONS
        output$value <- renderPrint({paste(
                                         "youtube-dl", options, options2, url)
        })
        system(paste("youtube-dl", options, url))
    })
}

shinyApp(ui, server)
