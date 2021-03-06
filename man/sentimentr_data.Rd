% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/combine_data.R
\name{available_data}
\alias{available_data}
\alias{sentimentr_data}
\title{Get Available Data}
\usage{
available_data(regex = NULL, package = "sentimentr", ...)

sentimentr_data(regex = NULL, package = "sentimentr", ...)
}
\arguments{
\item{regex}{A regex to search for within the data columns.}

\item{package}{The name of the package to extract data from.}

\item{\ldots}{Other arguments passed to \code{grep}.}
}
\value{
Returns a data.frame
}
\description{
See available \pkg{sentimentr} data a data.frame.  Note that 
\code{sentimentr_data} is the main function to be used but 
\code{available_data} is exposed to allow other packages to use the
functionality in a generic way.
}
\examples{
sentimentr_data()
available_data() ## generic version for export
available_data(package = 'datasets')
sentimentr_data('^hu')
sentimentr_data('^(hu|kot)')
combine_data(sentimentr_data('^(hu|kot)')[[1]])

\dontrun{
if (!require("pacman")) install.packages("pacman")
pacman::p_load(sentimentr, tidyverse, magrittr)

sentiment_data <- sentimentr_data('^hu') \%>\%
    pull(Data) \%>\%
    combine_data() \%>\%
    mutate(id = seq_len(n())) \%>\%
    as_tibble()
    
sentiment_test <- sentiment_data \%>\%
    select(-sentiment) \%>\%
    get_sentences() \%$\%
    sentiment(., by = c('id'))

testing <- sentiment_data \%>\%
    left_join(sentiment_test, by = 'id') \%>\%
    as_tibble() \%>\%
    mutate(
        actual = sign(sentiment),
        predicted = sign(ave_sentiment)
    )

testing \%$\%
    ftable(predicted, actual)
}
}
