#Server.R
library(UsingR)
library(gbm)
library(e1071)
library(caret)
library(MASS)
modFitGBM<-train(type~npreg+glu+bmi+age,method="gbm", verbose = FALSE, data=Pima.tr)
library(ggplot2)
diagnostic <- function(npreg,glu,bmi,age)
{
  myList <- list("npreg"=npreg, "glu"=glu, "bmi"=bmi, "age"=age)
  if((predict(modFitGBM, myList)=="No"))
      myPhrase<-"Patient is not suffering from Diabetes"
  else
      myPhrase<-"Patient is suffering from Diabetes"
  
  #paste(myPhrase, " ", max(predict(modFitGBM, myList),type="prob"))
  
  paste (predict(modFitGBM, myList), ":", myPhrase, "with probability of", round(100*max(predict(modFitGBM, myList, type="prob"))), "%")
}

shinyServer(
  function(input, output) {
    output$oid1 <- renderPrint({input$id1})
    output$oid2 <- renderPrint({input$id2})
  
    #As bmi will be reused across multiple places, we make it reactive
    bmi<-reactive({as.numeric(input$wt/(input$ht^2))})
        
    output$obmi <- renderText({bmi()})
    output$obmi2 <- renderText({bmi()})
    
    output$prediction <- renderText({diagnostic(input$npreg, input$glu, bmi(), input$age)})
    
    output$newHist <- renderPlot({
      hist(Pima.tr$bmi, xlab = 'Body Mass Index', col = 'blue', main ='Body Mass Index Histogram')
      bmi <- bmi()
      lines(c(bmi, bmi), c(0,200), col="red", lwd=10)
    })

  }
  
)