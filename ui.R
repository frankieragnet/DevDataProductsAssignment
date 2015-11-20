library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Diabetes prediction"),
    sidebarPanel(
      h3('Test for diabetes'),
      sliderInput('glu','Plasma glucose concentration in oral test', 120, min = 50, max = 200, step = 5),
      sliderInput('ht','Height (m)', 1.50, min = 1.00, max = 2.50, step = 0.01),
      sliderInput('wt', 'Weight (kg)', value = 50, min = 30, max = 200, step = 1),
      numericInput('age','Age', 20, min = 10, max = 120, step = 1),      
      numericInput('npreg','Number of pregnancies', 0, min = 0, max = 20, step = 1)
#     , submitButton('Submit')
  ),
  mainPanel(
      tabsetPanel(
        tabPanel("About",
                 h2("Background"),
                 p("This application predicts whether a (female) patient has Diabetes or not, based on a set of parameters that can be easily collected."),
                 p("It  is based on an advanced Machine Learning Prediction model built using data from a study of Diabetes in Pima Indian Women (for more information on the dataset, check R:Diabetes in Pima Indian Women in the MASS package)."),
                 p("The application also compares the patient's characteristics (e.g. Body Mass Index) with the test population's on a histogram."),
                 h2("How to use"),
                 p("Enter the required information on the left sidebar panel:"),
                 HTML("<UL><LI><B>Plasma glucose concentration in oral test:</B> plasma glucose concentration in an oral glucose tolerance test.</LI>"),
                 HTML("<LI><B>Height and Weight:</B> Those are used to compute the Body Mass Index (BMI). Please make sure you express Height in meters and Weight in kg.</LI>"),
                 HTML("<LI><B>Age:</B> Age of the patient in years.</LI>"),
                 HTML("<LI><B>Number of Pregnancies</B> this woman has had.</LI></UL>"),
                 p("Based on these input parameters, a prediction and probability will be computed for the patient being diabetic according to WHO criteria. This will be visible on the Results tab."),
                 p("Finally, a plot of the patient's parameter (e.g. BMI) compared to test population will be displayed on the Plots tab."),
                 p("You can re-run the application as many times as you like.")          
                 ),
        tabPanel("Results",
          h2('Results of prediction'),          
          h4('Based on the parameters you entered, Computed Body Mass Index (BMI) for the patient is:'),
          verbatimTextOutput("obmi"),
          h4('Based on this and other parameters, prediction for the current patient is:'),
          verbatimTextOutput("prediction")
        ),
    tabPanel("Plots", 
             h4('Based on the parameters you entered, Computed Body Mass Index (BMI) for the patient is:'),
             verbatimTextOutput("obmi2"),
             plotOutput('newHist')))
  
  )
))